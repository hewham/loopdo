require 'tty-prompt'
require 'date'
require 'colorize'


# if recurring, check base schedule, if no conflicts, check appointments -> no need to check availability_blocks
# if one-off, check availability blocks, if none, check base schedule, then appointments

# Scenarios to test:
#   recurring appointments:
#       conflict with sp's base availability
#       conflict with sp's availability blocks
#       conflict with sp's appointments
#       no conflicts -- should create appointment and (change sp's base availability or add recurring availability block)
#   one-off appointments:
#       conflict with sp's base availability
#       conflict with sp's availability blocks
#       conflict with sp's appointments
#       no conflicts -- should create appointment



def create_app
    prompt = TTY::Prompt.new

    # get services and service providers
    service_names = DshsData.instance.services.keys
    service_provider_names = DshsData.instance.service_providers.keys

    # client name?
    user_name = prompt.ask("What is your name?")

    # which service?
    user_service = prompt.select("Which service are you making an appointment for?", service_names, cycle: true)
    service_length = DshsData.instance.services[user_service]['length']

    # which service provider? only allow user to select from service providers that offer the specified service
    possible_service_providers = []
    service_provider_names.each do |sp|
        if DshsData.instance.service_providers[sp]['services'].include? user_service
            possible_service_providers << sp
        end
    end

    user_sp = prompt.select("Which service provider are you making an appointment with?", possible_service_providers, cycle: true)

    # determine whether this appointment is recurring or one-off
    recurring_or_one_off = prompt.select("Is this a recurring (weekly) appointment? Or a one-off appointment?", ['recurring', 'one-off'], cycle: true)
    if recurring_or_one_off == 'recurring'
        is_recurring = true
    else
        is_recurring = false
    end

    # what date and time? check for conflicts while doing so
    conflict_exists = true
    while conflict_exists do
        base_date = prompt.ask("Appointment date (MM/DD/YYYY):")
        break if base_date == 'q'
        # which day of the week did they specify?
        base_day = Date.strptime(base_date, "%m/%d/%Y").cwday
        case base_day
        when 1
            user_day = 'monday'
        when 2
            user_day = 'tuesday'
        when 3
            user_day = 'wednesday'
        when 4
            user_day = 'thursday'
        when 5
            user_day = 'friday'
        when 6
            user_day = 'saturday'
        when 7
            user_day = 'sunday'
        else
            puts base_day
            puts 'invalid day'
        end

        # convert date to number of days since epoch
        user_date = Date.strptime(base_date, "%m/%d/%Y").to_time.to_i / (60 * 60 * 24)

        base_time = prompt.ask("Appointment start time (ex: 10am or 2pm):")
        # the following code converts user_time to an index where each hour of the day is represented by a number between 0-23
        user_time = base_time.tr('apm', '').to_i() - 1
        am_or_pm = base_time.tr('0-9', '')
        if am_or_pm == 'pm' && user_time != 11
            user_time += 12
        elsif am_or_pm == 'am' && user_time == 11
            user_time += 12
        end

        # check for conflicts in service_provider's availability blocks
        should_continue = false
        base_availability_override = false
        DshsData.instance.availability_blocks.each do |av|
            if (!is_recurring && av['date'] == user_date && av['service_provider_name'] == user_sp) || (is_recurring && convert_date_to_day(av['date']) == user_day)
                if user_time >= av['start_time'] && user_time < av['end_time']
                    if av['is_available'] && !is_recurring
                        # the override flag is set to denote that availability blocks take
                        # precedence over base availability - this is used when checking
                        # for conflicts in the service_provider's base availability
                        base_availability_override = true
                        break
                    elsif av['is_available'] && is_recurring
                        next
                    else
                        puts 'The service provider you requested is not available at this time.'.red
                        puts 'Please choose a different date/time or \'q\' to quit.'.red
                        should_continue = true
                        break
                    end
                end
            end
        end
        # should_continue happens if the time requested has conflicts
        # this line ends the current iteration of the loop and asks for a new date/time
        next if should_continue

        # check for conflicts in service_provider's base availability
        if !DshsData.instance.service_providers[user_sp]['availability'][user_day][user_time] && !base_availability_override
            puts 'The service provider you requested is not available at this time.'.red
            puts 'Please choose a different date/time or \'q\' to quit.'.red
            next
        end

        # check for conflicts in service_provider's appointments on specified day
        should_continue = false
        DshsData.instance.appointments.each do |app|
            if (!is_recurring && app['date'] == user_date && app['service_provider_name'] == user_sp) || (is_recurring && convert_date_to_day(app['date']) == user_day)
                if user_time >= app['start_time'] && user_time < (app['start_time'] + DshsData.instance.services[app['service_name']]['length'])
                    puts 'The service provider you requested already has an appointment at this time.'.red
                    puts 'Please choose a different date/time or \'q\' to quit.'.red
                    should_continue = true
                    break
                end
            end
        end
        # should_continue happens if the time requested has conflicts
        # this line ends the current iteration of the loop and asks for a new date/time
        next if should_continue

        conflict_exists = false
    end

    # if no conflicts, add to appointments array
    if !conflict_exists
        if is_recurring
            # change service provider's base availability for a recurring appointment
            for index in user_time..(user_time + service_length - 1)
                DshsData.instance.service_providers[user_sp]['availability'][user_day][index] = false
            end
        end

        DshsData.instance.create_appointment(user_date, user_time, user_service, user_sp, user_name)
    end
end


def convert_date_to_day(days_since_epoch) # days_since_epoch = number of days that have elapsed since Thursday, 1 January 1970
    weekday = days_since_epoch % 7
    case weekday
    when 0
        'thursday'
    when 1
        'friday'
    when 2
        'saturday'
    when 3
        'sunday'
    when 4
        'monday'
    when 5
        'tuesday'
    when 6
        'wednesday'
    else
        puts 'weekday ' + weekday
        puts 'invalid day'
    end
end

require 'tty-prompt'


def prompt_add_sp
    prompt = TTY::Prompt.new

    # basic info
    service_provider_name_in = prompt.ask('Service provider name:')
    phone_in = prompt.ask('Phone #:')

    # which services are provided?
    services_in = prompt.multi_select('Services provided:', DshsData.instance.services.keys)

    # check availability
    availability_in = {
                            "monday" => [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false],
                            "tuesday" => [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false],
                            "wednesday" => [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false],
                            "thursday" => [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false],
                            "friday" => [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false],
                            "saturday" => [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false],
                            "sunday" => [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
                        }
    times = ['1am', '2am', '3am', '4am', '5am', '6am', '7am', '8am', '9am', '10am', '11am', '12pm', '1pm', '2pm', '3pm', '4pm', '5pm', '6pm', '7pm', '8pm', '9pm', '10pm', '11pm', '12am']
    av = {}
    av['monday'] = prompt.multi_select('When are you available on Mondays:', times)
    av['tuesday'] = prompt.multi_select('When are you available on Tuesdays:', times)
    av['wednesday'] = prompt.multi_select('When are you available on Wednesdays:', times)
    av['thursday'] = prompt.multi_select('When are you available on Thursdays:', times)
    av['friday'] = prompt.multi_select('When are you available on Fridays:', times)
    av['saturday'] = prompt.multi_select('When are you available on Saturdays:', times)
    av['sunday'] = prompt.multi_select('When are you available on Sundays:', times)

    av.keys.each do |day|
        av[day].each do |time|
            time_index = time.tr('apm', '').to_i() - 1
            am_or_pm = time.tr('0-9', '')
            if am_or_pm == 'pm' && time_index != 11
                time_index += 12
            elsif am_or_pm == 'am' && time_index == 11
                time_index += 12
            end
            availability_in[day][time_index] = true
        end
    end


    DshsData.instance.add_service_provider(service_provider_name_in, phone_in, services_in, availability_in)
end

def prompt_remove_sp
    prompt = TTY::Prompt.new

    name_is_valid = false
    while !name_is_valid do
        service_provider_name_in = prompt.ask('Service provider name:')
        if DshsData.instance.service_providers[service_provider_name_in] != nil
            name_is_valid = true
        else
            puts 'That service provider does not exist! Please choose a different name.'.red
        end
    end

    DshsData.instance.remove_service_provider(service_provider_name_in)
end


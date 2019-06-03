
require_relative './service'
require_relative './serviceProvider'
require_relative './appointment'
require_relative './timeblock'
require_relative './print'
require_relative './init'
require_relative './colors'
require_relative './availability'
require 'tty-prompt'
$prompt = TTY::Prompt.new

def find_sp_by_service(serviceName)
  sp_with_service = []
  for sp in $all_sp do
    for s in sp.services do
      if s.name == serviceName
        sp_with_service.push(sp)
        break
      end
    end
  end
  return sp_with_service
end

def get_sp_by_name(name)
  sp = $all_sp.select do |sp| 
    sp.name == name
  end
  if sp.length == 1
    return sp.first
  else
    return false
  end
end

def serviceAdd
  service_name = $prompt.ask('Service Name:')
  service_price = $prompt.ask('Service Price:')
  service_length = $prompt.ask('Service Length (Mins):')
  loop do
    spPrint($all_sp)
    provider_name = $prompt.ask('Add to which provider?:')
    sp = get_sp_by_name(provider_name)
    if sp
      sp.serviceAdd(Service.new(service_name, service_price, service_length))
      successPrint()
      break
    else
      serviceErrorMessage()
    end
  end
end

def serviceRemove
  puts "Choose Service to Remove"
  servicePrint($all_sp)
  provider_name = $prompt.ask('Service Provider:')
  service_name = $prompt.ask('Service Name:')
  spToRemove = nil
  isFound = false
  sp = $all_sp.select do |sp|
    if sp.name == provider_name
      spToRemove = sp
      isFound = true
      break      
    end
  end
  if isFound
    spToRemove.serviceRemove(service_name)
    successPrint()
  else
    serviceErrorMessage()
  end
end

def spAdd
  provider_name = $prompt.ask('Provider Name:')
  provider_phone = $prompt.ask('Provider Phone Number:')
  $all_sp.push(ServiceProvider.new(provider_name, provider_phone, [], {}, []))
  successPrint()
end

def spRemove
  provider_name = $prompt.ask('Provider Name To Remove:')
  $all_sp.each do |sp|
    if sp.name == provider_name
      puts "Deleting #{provider_name}"
      confirm = y_or_n()
      if confirm
        $all_sp.delete(sp)
        successPrint()
      else
        puts 'Did Not Delete'
      end
    end
  end
end

def y_or_n
  loop do
    yn = $prompt.ask('(y/n):')
    if yn == 'y'
      return true
    elsif yn == 'n'
      return false
    else
      puts "Enter y or n"
    end
  end
end

def appointmentAdd
  client_name = $prompt.ask('Client Name:')
  puts "Hello #{client_name}! Choose Provider & Service to Schedule"
  servicePrint($all_sp)
  provider_name = $prompt.ask('Provider Name:')
  service_name = $prompt.ask('Service Name:')
  month = $prompt.ask('Date (MM):')
  day = $prompt.ask('Date (DD):')
  year = $prompt.ask('Date (YYYY):')
  start_time = $prompt.ask('Start Time (ex: 13:30):')
  temp = start_time.split(':')
  hour = temp[0].to_i
  minute = temp[1].to_i
  puts 'Will This Appointment Reoccur Weekly?'
  isWeekly = y_or_n()
  sp = get_sp_by_name(provider_name)
  service = sp.containsService(service_name)

  start_datetime = DateTime.new(year.to_i, month.to_i, day.to_i, hour, minute)
  sp.add_appointment(service, TimeBlock.new(start_datetime, isWeekly, service.length), client_name)
  successPrint()
end

def appointmentRemove
  spPrint($all_sp)
  provider_name = $prompt.ask('Provider Name To Cancel Appt:')
  client_name = $prompt.ask('Your Name:')
  sp = get_sp_by_name(provider_name)
  i = 1;
  sp.appointments.each do |a|
    if a.client_name == client_name
      puts "#{BgCyan}APPOINTMENT #{i}#{Reset}"
      a.printDetails
      i += 1
    end
  end
  if i == 1
    puts "No appointments found for client (#{Cyan}#{client_name}#{Reset}) under service provider (#{Magenta}#{provider_name}#{Reset})."
  else
    loop do
      indexRemove = $prompt.ask('Choose Appointment to remove by number (q to quit):')
      if indexRemove.to_i - 1 >= 0 && indexRemove.to_i <= i - 1
        # this could be a lot better but oh well
        i = 1;
        apptToRemove = nil
        sp.appointments.each do |a|
          if a.client_name == client_name
            if i == indexRemove.to_i
              apptToRemove = a
              break
            end
            i += 1
          end
        end
        sp.appointments.delete(apptToRemove)
        successPrint()
        break
      elsif indexRemove == 'q'
        break
      else
        puts "Choose an existing appointment"
      end
    end
  end
end

def availabilityAdd
  spPrint($all_sp)
  provider_name = $prompt.ask('Provider Name:')
  month = $prompt.ask('Date (MM):')
  day = $prompt.ask('Date (DD):')
  year = $prompt.ask('Date (YYYY):')
  start_time = $prompt.ask('Start Time (ex: 13:30):')
  end_time = $prompt.ask('End Time (ex: 14:30):')
  puts 'Will This Appointment Reoccur Weekly?'
  isWeekly = y_or_n()

  start_temp = start_time.split(':')
  start_hour = start_temp[0].to_i
  start_minute = start_temp[1].to_i

  end_temp = end_time.split(':')
  end_hour = end_temp[0].to_i
  end_minute = end_temp[1].to_i

  length = (end_hour * 60 +end_minute) - (start_hour * 60 + start_minute)

  sp = get_sp_by_name(provider_name)

  start_datetime = DateTime.new(year.to_i, month.to_i, day.to_i, start_hour, start_minute)
  timeblock = TimeBlock.new(start_datetime, isWeekly, length)

  #sp.add_appointment(service, TimeBlock.new(month, day, year, start_datetime, isWeekly, service.length), client_name)
  sp.add_availability(timeblock)
  successPrint()
end

def scheduleView(type)
  loop do
    puts "Choose a Service Provider to see their schedule:"
    spPrint($all_sp)
    provider_name = $prompt.ask('Provider Name (q to quit):')
    spToUse = nil
    isFound = false
    sp = $all_sp.select do |sp|
      if sp.name == provider_name
        spToUse = sp
        isFound = true
        break      
      end
    end
    if isFound
      if type == 'appt'
        spToUse.scheduleView()
        break
      elsif type == 'avail'
        spToUse.availabilityView()
        break
      end
    elsif provider_name == 'q'
      break
    else
      serviceErrorMessage()
    end
  end
end

def list_commands
  puts "#{BgCyan}COMMAND LIST:#{Reset}"
  puts "--------------------------------"
  puts "#{Cyan}commands#{Reset} | View this list of commands"
  puts "#{Cyan}s:add#{Reset} | Add service"
  puts "#{Cyan}s:remove#{Reset} | Remove service"
  puts "#{Cyan}s:view#{Reset} | Display all services"
  puts "#{Cyan}sp:add#{Reset} | Add service provider"
  puts "#{Cyan}sp:remove#{Reset} | Remove service provider"
  puts "#{Cyan}sp:view#{Reset} | Display all service providers"
  puts "#{Cyan}appt:add#{Reset} | Add new appointment"
  puts "#{Cyan}appt:remove#{Reset} | Remove appointment"
  puts "#{Cyan}avail:add#{Reset} | Add new availability block"
  puts "#{Cyan}schedule:view#{Reset} | View schedule"
  puts "--------------------------------"
end

commands = {
  's:add' => Proc.new{serviceAdd},
  's:remove' => Proc.new{serviceRemove},
  's:view' => Proc.new{servicePrint($all_sp)},
  'sp:add' => Proc.new{spAdd},
  'sp:remove' => Proc.new{spRemove},
  'sp:view' => Proc.new{spPrint($all_sp)},
  'appt:add' => Proc.new{appointmentAdd},
  'appt:remove' => Proc.new{appointmentRemove},
  'avail:add' => Proc.new{availabilityAdd},
  'avail:view' => Proc.new{scheduleView('avail')},
  'schedule:view' => Proc.new{scheduleView('appt')},
  'commands' => Proc.new{list_commands}
}

# INITIALIZE
$all_sp = initData

loop do
  next_prompt = $prompt.ask('Please enter a command:')
  puts ''
  isCommand = false
  commands.each do |command, function|
    if next_prompt == command
      function.call()
      isCommand = true
    end
  end
  if !isCommand
    puts "#{BgRed}Unknown command:#{Reset} #{Red}#{next_prompt}#{Reset}"
    puts ""
    list_commands
    next
  end
end




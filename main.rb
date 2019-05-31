
require_relative './service'
require_relative './serviceProvider'
require_relative './appointment'
require_relative './timeblock'
require_relative './print'
require_relative './init'
require_relative './colors'
require 'tty-prompt'
$prompt = TTY::Prompt.new

def successPrint
  puts 'Success!'
  puts ''
end

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

def serviceErrorMessage
  puts ''
  puts 'Service Provider Not Found...'
  puts 'Choose from the following:'
  spPrint($all_sp)
end

def serviceAdd
  service_name = $prompt.ask('Service Name:')
  service_price = $prompt.ask('Service Price:')
  service_length = $prompt.ask('Service Length (Mins):')
  loop do
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
  service_name = $prompt.ask('Service Name:')
  provider_name = $prompt.ask('Service Provider:')
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
  client_name = $prompt.ask('Your Name:')
  puts "Hello #{client_name}! Choose Provider & Service to Schedule"
  servicePrint($all_sp)
  provider_name = $prompt.ask('Provider Name:')
  service_name = $prompt.ask('Service Name:')
  month = $prompt.ask('Date (MM):')
  day = $prompt.ask('Date (DD):')
  year = $prompt.ask('Date (YYYY):')
  start_time = $prompt.ask('Start Time (24h):')
  stop_time = $prompt.ask('Stop Time (24h):')
  puts 'Will This Appointment Reoccur Weekly?'
  isWeekly = y_or_n()
  sp = get_sp_by_name(provider_name)
  service = sp.containsService(service_name)
  sp.appointments.push(Appointment.new(TimeBlock.new(month, day, year, start_time, stop_time, isWeekly), service, client_name, sp))
  successPrint()
end

def availabilityAdd
end
def scheduleView
  provider_name = $prompt.ask('Provider Name:')
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
    spToUse.scheduleView()
    successPrint()
  else
    serviceErrorMessage()
  end

end

def list_commands
  puts 'CURRENT COMMAND LIST:'
  puts 'Add service: s:add'
  puts 'Remove service: s:remove'
  puts 'Display all services: s:list'
  puts 'Add service provider: sp:add'
  puts 'Remove service provider: sp:remove'
  puts 'Display all service providers: sp:list'
  puts 'Add new appointment: appt:add'
  puts 'Add new availability block: avail:add'
  puts 'View schedule: schedule:view'
  puts "--------------------------------"
end

commands = {
  's:add' => Proc.new{serviceAdd},
  's:remove' => Proc.new{serviceRemove},
  's:list' => Proc.new{servicePrint($all_sp)},
  'sp:add' => Proc.new{spAdd},
  'sp:remove' => Proc.new{spRemove},
  'sp:list' => Proc.new{spPrint($all_sp)},
  'appt:add' => Proc.new{appointmentAdd},
  'avail:add' => Proc.new{availabilityAdd},
  'schedule:view' => Proc.new{scheduleView},
}

# INITIALIZE
$all_sp = initData

loop do
  next_prompt = $prompt.ask('Please enter a command:')
  isCommand = false
  commands.each do |command, function|
    if next_prompt == command
      function.call()
      isCommand = true
    end
  end
  if !isCommand
    puts "Unknown command #{next_prompt}"
    puts "--------------------------------"
    list_commands
    next
  end
end




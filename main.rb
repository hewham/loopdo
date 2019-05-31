
require_relative './service'
require_relative './serviceProvider'
require_relative './appointment'
require_relative './timeblock'
require_relative './print'
require_relative './init'
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

def list_commands
  puts 'CURRENT COMMAND LIST:'
  puts 'Add service: s:add'
  puts 'Remove service: s:remove'
  puts 'Display all services: s:show'
  puts 'Add service provider: sp:add'
  puts 'Remove service provider: sp:remove'
  puts 'Display all service providers: sp:show'
  puts 'Add new appointment: appointment:add'
  puts 'Add new availability block: availability:add'
  puts 'View schedule: schedule:view'
  puts "--------------------------------"
end

def serviceAdd
  service_name = $prompt.ask('Service Name:')
  service_price = $prompt.ask('Service Price:')
  service_length = $prompt.ask('Service Length (Mins):')
  loop do
    provider_name = $prompt.ask('Add to which provider?:')
    sp = $all_sp.select do |sp| 
      sp.name == provider_name
    end
    if sp.length == 1
      sp.first.serviceAdd(Service.new(service_name, service_price, service_length))
      successPrint()
      break
    else
      puts ''
      puts 'Service Provider Not Found...'
      puts 'Choose from the following:'
      spPrint($all_sp)
    end
  end
end

def serviceRemove
  service_name = $prompt.ask('Service Name:')
  provider_name = $prompt.ask('Service Provider:')
  sp = $all_sp.select do |sp|
    if sp.name == provider_name
      puts '+++++++++++++++++++++++++++++++++++++++++++'
      puts sp
      sp.serviceRemove(service_name)
      successPrint
      break
    else
      puts ''
      puts 'Service Provider Not Found...'
      puts 'Choose from the following:'
      spPrint($all_sp)
    end
  end
end

def spAdd
end
def spRemove
end
def appointmentAdd
end
def availabilityAdd
end
def scheduleView
end

commands = {
  's:add' => Proc.new{serviceAdd},
  's:remove' => Proc.new{serviceRemove},
  's:show' => Proc.new{servicePrint($all_sp)},
  'sp:add' => Proc.new{spAdd},
  'sp:remove' => Proc.new{spRemove},
  'sp:show' => Proc.new{spPrint($all_sp)},
  'appointment:add' => Proc.new{appointmentAdd},
  'availability:add' => Proc.new{availabilityAdd},
  'schedule:view' => Proc.new{scheduleView},
}

# INITIALIZE
$all_sp = initData

loop do
  next_prompt = $prompt.ask('Please enter a command:')
  isCommand = false
  commands.each do |command, function|
    if next_prompt == command
      # command[:function]
      puts "COMMAND: #{command}"
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




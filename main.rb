
require_relative './service'
require_relative './serviceProvider'
require_relative './appointment'
require_relative './timeblock'
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

def printSP
  puts ''
  puts 'SERVICE PROVIDERS:'
  puts '------------------'
  $all_sp.each do |sp|
    puts sp.name
  end
  puts '------------------'
  puts ''
end

$all_sp = []
$all_sp.push(ServiceProvider.new('Jim', '1111111111', [Service.new('DEMON HUNTING', 200, 60)], {}, []))

def serviceAdd
  service_name = $prompt.ask('Service Name:')
  service_price = $prompt.ask('Service Price:')
  service_length = $prompt.ask('Service Length (Mins):')
  puts service_name
  provider_name = $prompt.ask('Add to which provider? (Name):')
  sp = $all_sp.select do |sp| 
    puts "SP NAME: " + sp["name"]
    sp["name"] == provider_name
  end
  sp.services.push(Service.new(service_name, service_price, service_length))
end

def serviceRemove
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
  'service:add' => Proc.new{serviceAdd},
  'service:remove' => Proc.new{serviceRemove},
  'sp:add' => Proc.new{spAdd},
  'sp:remove' => Proc.new{spRemove},
  'appointment:add' => Proc.new{appointmentAdd},
  'availability:add' => Proc.new{availabilityAdd},
  'schedule:view' => Proc.new{scheduleView},
  'sp:show' => Proc.new{printSP}
}


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
    next
  end
end




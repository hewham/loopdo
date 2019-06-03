require 'tty-prompt'
prompt = TTY::Prompt.new

puts("commands you can use:
      service:add
      service:remove
      provider:add
      provider:remove
      schedule:new
      schedule:list")


if ARGV[0] == 'service:add'
  name = prompt.ask('name:')
  price = prompt.ask('price:')
  length = prompt.ask('length:')

  File.open("service.txt", 'a') { |file| file.write("#{name}, #{price}, #{length} \n") }

elsif ARGV[0] == 'service:remove'
  name_remove = prompt.ask('name:')
  input_lines = File.readlines('service.txt')
  input_lines.map do |line|

    unless line.to_s.include? "#{name_remove}"
      File.open("service_tmp.txt", 'a') { |file| file.write("#{line}") }
    end

  end


elsif ARGV[0] == 'provider:add'
  provider_name = prompt.ask('provider name:')
  phone_number = prompt.ask('provider phone number:')
  service_list = prompt.ask('list of services provided:')

  File.open("provider.txt", 'a') { |file| file.write(" #{provider_name}, #{phone_number}, #{service_list} \n")}

elsif ARGV[0] == 'provider:remove'
  provider_remove = prompt.ask('name:')
  input_lines = File.readlines('provider.txt')
  input_lines.map do |line|

    unless line.to_s.include? "#{provider_remove}"
      File.open("provider_tmp.txt", 'a') { |file| file.write("#{line}") }
    end
  end

end
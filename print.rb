
def success_print
  puts 'Success!'
  puts ''
end

def service_error_message
  puts ''
  puts 'Service Provider Not Found...'
  puts 'Choose from the following:'
  service_provider_print($all_sp)
end

def service_provider_print(all_sp)
  puts "#{BgMagenta}SERVICE PROVIDERS:#{Reset}"
  puts '------------------'
  all_sp.each do |sp|
    puts "#{Magenta}#{sp.name}#{Reset}"
  end
  puts '------------------'
  puts ''
end

def service_print(all_sp)
  puts "#{BgCyan}SERVICES:#{Reset}"
  puts '------------------'
  for sp in all_sp do
    sp.print_services()
  end
  puts '------------------'
  puts ''
end
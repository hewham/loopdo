def spPrint(all_sp)
  puts ''
  puts 'SERVICE PROVIDERS:'
  puts '------------------'
  all_sp.each do |sp|
    puts sp.name
  end
  puts '------------------'
  puts ''
end

def servicePrint(all_sp)
  puts ''
  puts 'SERVICES:'
  puts '------------------'
  for sp in all_sp do
    sp.printServices()
  end
  puts '------------------'
  puts ''


end
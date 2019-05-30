def printSP(all_sp)
  puts ''
  puts 'SERVICE PROVIDERS:'
  puts '------------------'
  all_sp.each do |sp|
    puts sp.name
  end
  puts '------------------'
  puts ''
end
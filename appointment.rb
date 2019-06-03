class Appointment
  attr_reader :timeblock, :service, :client_name, :serviceProvider
  def initialize(timeblock, service, client_name, serviceProvider) (
    @timeblock = timeblock
    @service = service
    @client_name = client_name
    @serviceProvider = serviceProvider
  )
  end

  def printDetails()
    puts "#{Cyan} Client Name: #{@client_name}#{Reset}, #{Green} Provider Name:  #{@serviceProvider.name}#{Reset}, #{Yellow} Service Name:  #{@service.name}#{Reset}"
    puts "Date: #{@timeblock.month} / #{@timeblock.day} / #{@timeblock.year}"
    puts "Start Time: #{@timeblock.startTime}"
    puts "Stop Time: #{@timeblock.endTime}"
    puts "----------------------------------------------------------------------"
  end

end
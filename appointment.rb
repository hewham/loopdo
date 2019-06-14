class Appointment
  attr_reader :timeblock, :service, :client_name, :service_provider
  def initialize(timeblock, service, client_name, service_provider) (
    @timeblock = timeblock
    @service = service
    @client_name = client_name
    @service_provider = service_provider
  )
  end

  def print_details()
    puts get_details
    @timeblock.day_of_week
  end

  def get_details()
    day_text = nil
    if @timeblock.is_weekly
      day_text = " - on #{@timeblock.day_of_week}'s"
    end
    return "#{BgCyan}APPOINTMENT: #{Reset} Provider: #{Magenta}#{@service_provider.name}#{Reset}, Client: #{Cyan}#{@client_name}#{Reset}, Service: #{Yellow}#{@service.name}#{Reset} \n Date: #{Green}#{@timeblock.month}/#{@timeblock.day}/#{@timeblock.year}#{Reset} | Start: #{Green}#{@timeblock.start_time.strftime("%T")}#{Reset} | Stop: #{Green}#{@timeblock.end_time.strftime("%T")}#{Reset} | Weekly #{Green}#{@timeblock.is_weekly}#{day_text}#{Reset} \n ----------------------------------------------------------------------"
  end

end

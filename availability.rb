
class Availability
  attr_reader :start_timeblock, :end_timeblock, :service_provider
  def initialize(start_timeblock, end_timeblock, service_provider) (
    @start_timeblock = start_timeblock
    @end_timeblock = end_timeblock
    @service_provider = service_provider
  )
  end

  def print_details
    puts "Date: #{Green}#{@start_timeblock.month}/#{@start_timeblock.day}/#{@start_timeblock.year}#{Reset} | Start: #{Green}#{@start_timeblock.start_time.strftime("%T")}#{Reset} | Stop: #{Green}#{@start_timeblock.end_time.strftime("%T")}#{Reset} | Weekly #{Green}#{@start_timeblock.is_weekly}#{Reset}"
    [start_timeblock.month.to_s, start_timeblock.day.to_s, start_timeblock.year.to_s, start_timeblock.start_time.strftime("%T").to_s, start_timeblock.end_time.strftime("%T").to_s, start_timeblock.is_weekly.to_s]
  end
  
end

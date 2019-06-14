
class Availability
  attr_reader :start_timeblock, :end_timeblock, :serviceProvider
  def initialize(start_timeblock, end_timeblock, serviceProvider) (
    @start_timeblock = start_timeblock
    @end_timeblock = end_timeblock
    @serviceProvider = serviceProvider
  )
  end

  def printDetails
    puts "Date: #{Green}#{@start_timeblock.month}/#{@start_timeblock.day}/#{@start_timeblock.year}#{Reset} | Start: #{Green}#{@start_timeblock.startTime.strftime("%T")}#{Reset} | Stop: #{Green}#{@start_timeblock.endTime.strftime("%T")}#{Reset} | Weekly #{Green}#{@start_timeblock.isWeekly}#{Reset}"
    [start_timeblock.month.to_s, start_timeblock.day.to_s, start_timeblock.year.to_s, start_timeblock.startTime.strftime("%T").to_s, start_timeblock.endTime.strftime("%T").to_s, start_timeblock.isWeekly.to_s]
  end
  
end

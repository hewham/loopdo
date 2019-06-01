
class Service
  attr_reader :name, :price, :length, :printDetails
  def initialize(name, price, length) (
    @name = name
    @price = price
    @length = length
  )
  end

  def printDetails
    puts "#{Cyan}#{@name}#{Reset}, #{Green}$#{@price}#{Reset}, #{Yellow}#{@length} Minutes#{Reset}"
  end

  def service_to_timeblock(startTime, isWeekly)
    dayOfWeek = startTime.strftime("%A")
    stopTime = startTime + ((length.to_f)/24)/60
    month = startTime.strftime("%m")
    day = startTime.strftime("%d")
    year = startTime.strftime("%Y")
    timeblock = Timeblock.new(month, day, year, startTime, stopTime, isWeekly)
  end
end
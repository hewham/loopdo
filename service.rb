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

  def service_to_timeblock(startTime, isWeekly, date)
    dayOfWeek = date.strftime("%A")
    stopTime = startTime + length/30
    timeblock = Timeblock.new(dayOfWeek, date, startTime, stopTime, isWeekly)
  end
end
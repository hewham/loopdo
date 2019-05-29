class TimeBlock
  attr_reader :dayOfWeek, :date, :startTime, :stopTime, :isWeekly
  def initialize(dayOfWeek, date, startTime, stopTime, isWeekly) (
    @dayOfWeek = dayOfWeek
    @date = date
    @startTime = startTime
    @stopTime = stopTime
    @isWeekly = isWeekly
  )
  end
end
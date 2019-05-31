class TimeBlock
  attr_reader :month, :day, :year, :startTime, :stopTime, :isWeekly
  def initialize(month, day, year, startTime, stopTime, isWeekly) (
    @month = month
    @day = day
    @year = year
    @startTime = startTime #integer between 0 and 47
    @stopTime = stopTime #integer between 0 and 47
    @isWeekly = isWeekly
  )
  end

  def contains(timeblock2)
    #return true if the timeblock contains timeblock2
    starts_after = (timeblock2.startTime >= @startTime)
    ends_before = (timeblock2.endTime <= @endTime)
    return starts_after && ends_before
  end

  def overlaps(timeblock2)
  	#returns true if timeblocks overlap (regardless of date)
  	overlaps_start = (timeblock2.startTime <= @startTime && 
  		timeblock2.endTime > @startTime)
  	overlaps_end = (timeblock2.startTime < @endTime && 
  		timeblock2.endTime >= @endTime)
  	return contains(timeblock2) || overlaps_start || overlaps_end
  end

end
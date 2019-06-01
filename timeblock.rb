class TimeBlock
  attr_reader :month, :day, :year, :startTime, :endTime, :dayOfWeek, :isWeekly
  def initialize(month, day, year, startTime, isWeekly, length) (
    @month = month
    @day = day
    @year = year
    @startTime = startTime
    @isWeekly = isWeekly
    @endTime = startTime + ((length.to_f)/24)/60
    @dayOfWeek = startTime.strftime("%A")
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

  def calculate_endtime(startTime, length)
    return startTime + ((length.to_f)/24)/60
  end
end
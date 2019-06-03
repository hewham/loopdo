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
  	#returns true if timeblocks overlap
  	# overlaps_start = (timeblock2.startTime <= @startTime &&
  	# 	timeblock2.endTime > @startTime)
  	# overlaps_end = (timeblock2.startTime < @endTime &&
  	# 	timeblock2.endTime >= @endTime)
  	# return contains(timeblock2) || overlaps_start || overlaps_end
    check1 = (timeblock2.startTime < @endTime &&
        timeblock2.endTime > @startTime)
    check2 = (@startTime < timeblock2.endTime &&
        @endTime > timeblock2.startTime)
    return check1 || check2
  end

  def overlaps_time(timeblock2)
  	#returns true if timeblocks overlap (regardless of date)
  	startTime1 = Time.parse(@startTime.to_s)
  	startTime2 = Time.parse(timeblock2.startTime.to_s)
  	endTime1 = Time.parse(@endTime.to_s)
  	endTime2 = Time.parse(timeblock2.endTime.to_s)

  	check1 = (startTime2 < endTime1 &&
        endTime2 > startTime1)
  	puts(check1)
    check2 = (startTime1 < endTime2 &&
        endTime1 > startTime2)
    puts(check2)
    return check1 || check2
  end

  def calculate_endtime(startTime, length)
    return startTime + ((length.to_f)/24)/60
  end
end
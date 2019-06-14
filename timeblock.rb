class TimeBlock
  attr_reader :month, :day, :year, :start_time, :end_time, :day_of_week, :is_weekly
  def initialize(start_time, is_weekly, length) (
    @month = start_time.strftime("%m")
    @day = start_time.strftime("%d")
    @year = start_time.strftime("%Y")
    @start_time = start_time
    @is_weekly = is_weekly
    @end_time = start_time + ((length.to_f)/24)/60
    @day_of_week = start_time.strftime("%A")
  )
  end

  def contains(new_timeblock)
    #return true if the timeblock contains timeblock2
    starts_after = (new_timeblock.start_time >= @start_time)
    ends_before = (new_timeblock.end_time <= @end_time)
    return starts_after && ends_before
  end

  def contains_time(new_timeblock)
    #return true if the timeblock contains timeblock2 (regardless of date)

    start_time_1 = Time.parse(@start_time.strftime("%H:%M:%S %z"))
  	start_time_2 = Time.parse(new_timeblock.start_time.strftime("%H:%M:%S %z"))
  	end_time_1 = Time.parse(@end_time.strftime("%H:%M:%S %z"))
    end_time_2 = Time.parse(new_timeblock.end_time.strftime("%H:%M:%S %z"))

    starts_after = (start_time_2 >= start_time_1)
    ends_before = (end_time_2 <= end_time_1)
    return starts_after && ends_before
  end

  def overlaps(new_timeblock)
    #returns true if timeblocks overlap

    check1 = (new_timeblock.start_time >= @start_time &&
        new_timeblock.start_time <= @end_time)
    check2 = (@start_time >= new_timeblock.start_time &&
        @start_time <= new_timeblock.end_time)
    return check1 || check2
  end

  def overlaps_time(new_timeblock)
    #returns true if timeblocks overlap (regardless of date)

  	start_time_1 = Time.parse(@start_time.strftime("%H:%M:%S %z"))
  	start_time_1 = Time.parse(new_timeblock.start_time.strftime("%H:%M:%S %z"))
  	end_time_1 = Time.parse(@end_time.strftime("%H:%M:%S %z"))
  	end_time_2 = Time.parse(new_timeblock.end_time.strftime("%H:%M:%S %z"))

    check1 = (start_time_1 >= start_time_1 &&
        start_time_1 <= end_time_1)

    check2 = (start_time_1 >= start_time_1 &&
        start_time_1 <= end_time_2)

    return check1 || check2
  end

  def calculate_endtime(start_time, length)
    return start_time + ((length.to_f)/24)/60
  end

  def print_details
    puts self.get_details
    [@start_time.month.to_s, @start_time.day.to_s, @start_time.year.to_s, @start_time.strftime("%T").to_s, @end_time.strftime("%T").to_s, @end_time.strftime("%T").to_s]
  end

  def get_details
    "Date: #{Green}#{@start_time.month}/#{@start_time.day}/#{@start_time.year}#{Reset} | Start: #{Green}#{@start_time.strftime("%T")}#{Reset} | Stop: #{Green}#{@end_time.strftime("%T")}#{Reset} | Weekly #{Green}#{@is_weekly}#{Reset}"
  end
end


class Availability
  attr_reader :start_timeblock, :end_timeblock, :serviceProvider
  def initialize(start_timeblock, end_timeblock, serviceProvider) (
    @start_timeblock = start_timeblock
    @end_timeblock = end_timeblock
    @serviceProvider = serviceProvider
  )
  end
  
end
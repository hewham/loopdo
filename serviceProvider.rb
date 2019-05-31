  # name
  # phoneNum
  # services = []
  # availability = hash{day:[TimeBlocks]}
  # appointments = []

class ServiceProvider
  attr_reader :name, :phoneNum, :services, :availability, :appointments, :serviceAdd
  def initialize(name, phoneNum, services, availability, appointments) (
    @name = name
    @phoneNum = phoneNum
    @services = services
    @availability = availability
    @appointments = appointments
  )
  end

  def serviceRemove(service_name) (
    for service in @services do
      if service.name == service_name
        @services.delete(service)
      end
    end
    )
  end

  def printServices()
    puts "#{Magenta}#{@name}'s#{Reset} Services:"
    @services.each do |s|
      s.printDetails
    end
  end

  def scheduleView()
    puts "#{Magenta}#{@name}'s#{Reset} Appointments:"
    @appointments.each do |a|
      a.printDetails
    end
  end

  def containsService(name) (
    for service in @services do
      if service.name == name
        return service
      end
    end
    return false
  )
  end

  def serviceAdd(service) (
    @services.push(service)
  )
  end
  def is_available(service, timeblock)
    #add check to make sure timeblock is in the future
    #check if provider offers service
    service_offered = containsService(service.name)

    #check provider's availability
    availability_blocks = @availability[timeblock.date]
    provider_available = false
    for block in availability_blocks do
      if block.contains(timeblock)
        provider_available = true
      end
    end

    #check for overlap with provider's appointments
    no_overlap_with_appointments = true
    appointments.each do |appointment|
      #check for overlap if appointment is weekly
      if appointment.timeblock.isWeekly
        if appointment.timeblock.dayOfWeek == timeblock.dayOfWeek
          if appointment.timeblock.overlaps(timeblock)
            no_overlap_with_appointments = false
            break
          end
        end
      end
      #check for overlap if dates are the same
      if appointment.timeblock.date == timeblock.date
        if appointment.timeblock.overlaps(timeblock)
          no_overlap_with_appointments = false
          break
        end
      end

      return service_offered && provider_available && no_overlap_with_appointments
    end

  end

  def add_appointment(service, timeblock)
    #add appointment to provider's schedule
  end


end
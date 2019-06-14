class ServiceProvider
  attr_reader :name, :phone_number, :services, :availability, :appointments, :service_add
  def initialize(name, phone_number, services, availability, appointments) (
    @name = name
    @phone_number = phone_number
    @services = services
    @availability = availability
    @appointments = appointments
  )
  end

  def service_remove(service_name) (
    for service in @services do
      if service.name == service_name
        @services.delete(service)
      end
    end
    )
  end

  def print_services()
    puts "#{Magenta}#{@name}#{Reset}'s Services:"
    @services.each do |s|
      s.print_details
    end
  end

  def schedule_view()
    puts
    puts "#{Magenta}#{@name}#{Reset}'s Appointments:"
    @appointments.each do |a|
      a.print_details
    end
    puts
  end

  def availability_view()
    puts
    puts "#{Magenta}#{@name}#{Reset}'s Availability:"
    @availability.each do |a|
      puts "#{BgCyan}AVAILABILITY#{Reset}"
      a.print_details
    end
    puts
  end

  def contains_service(name) (
    for service in @services do
      if service.name == name
        return service
      end
    end
    return false
  )
  end

  def service_add(service) (
    @services.push(service)
  )
  end
  
  def is_available(service, timeblock, isWeekly)
    #add check to make sure timeblock is in the future
    is_future_date = (timeblock.start_time >= DateTime.now)

    #check if provider offers service
    service_offered = contains_service(service.name)
    # puts('past service_offered')

    #check provider's availability
    # availability_blocks = @availability[timeblock.dayOfWeek]
    # puts('past availability_blocks')
    #IDK what is wrong with this but causes program to crash, commented out for now
    # provider_available = false
    # for block in availability_blocks do
    #   if block.contains(timeblock)
    #     provider_available = true
    #   end
    # end
    #
    provider_available = true

    #check for overlap with provider's appointments
    no_overlap_with_appointments = true
    puts('-----------------')
    @appointments.each do |appointment|
      #check for overlap if either appointment is weekly

      if appointment.timeblock.is_weekly || isWeekly
        if appointment.timeblock.day_of_week == timeblock.day_of_week
          if appointment.timeblock.overlaps_time(timeblock)
            no_overlap_with_appointments = false
          end
        end
      end
      #check for overlap if dates are the same

      if appointment.timeblock.overlaps(timeblock)
        no_overlap_with_appointments = false
      end
    end

    availability_contains = true
    @availability.each do |av|
      #check if appointment is contained within availability if availability is weekly

      if av.is_weekly || isWeekly
        if av.day_of_week == timeblock.day_of_week
          if !av.contains_time(timeblock)
            availability_contains = false
          end
        end
      else
        #check if appointment is contained within availability on same date
        if av.month == timeblock.month && av.day == timeblock.day && av.year == timeblock.year
          if !av.contains(timeblock)
            availability_contains = false
          end
        end
      end
    end

    return is_future_date && service_offered && provider_available && 
      no_overlap_with_appointments && availability_contains

  end

  def add_appointment(service, timeblock, client)
    #add appointment to provider's schedule
    if is_available(service, timeblock, timeblock.is_weekly)
      appointment = Appointment.new(timeblock, service, client, self)
      @appointments << appointment
      success_print()
      return true
    else
      puts "#{Red}The service provider you requested is not available at this time."
      puts "Please choose a different date/time.#{Reset}"
      return false
    end
  end

  def add_availability(timeblock)
    #need to add a check here
    @availability << timeblock
  end


end

class Service
  attr_accessor :name, :price, :length
  def initialize(name, price, length)
    @name = name
    @price = price
    @length = length
  end
end

class Provider
  attr_accessor :name, :service, :phone
  def initialize(name, service, phone)
    @name = name
    @service = service
    @phone = phone
  end

end

class Appointment
  attr_accessor :time, :service, :client, :provider
  def initialize(time, service, client, provider)
    @time = time
    @service = service
    @client = client
    @provider = provider
  end
end

class Unavailability
  attr_accessor :time, :provider, :length
  def initialize(time, provider, length)
    @time = time
    @provider = provider
    @length = length
  end
end

def appointment_validator(appointment, service_list, appointment_list, provider_list, unavailability_list)

  service_names = []
  service_lengths = []
  provider_names = []

  service_list.each do |service|
    service_names.push(service.name)
    service_lengths.push(service.length)
  end
  provider_list.each do |provider|
    provider_names.push(provider.name)
  end

  start_time = appointment.time
  # find the duration of the requested service
  index = service_names.index(appointment.service)
  end_time = start_time + 60*60*service_lengths[index].to_i

  if (!service_names.include?(appointment.service))
    puts "
          Please use service:add to add service
         "
  end

  if (!provider_names.include?(appointment.provider))
    puts "
          Please use provider:add to add provider
         "
  end

  appointment_temp = []
  appointment_list.each do |appointment_old|
    if (appointment_old.provider) == appointment.provider
      if (appointment_old.time.month) == appointment.time.month
        if (appointment_old.time.day) == appointment.time.day
          appointment_temp.push(appointment_old)
        end
      end
    end
  end


  validator = []
  appointment_temp.each do |app_temp|
    index = service_names.index(app_temp.service)
    app_temp_length = service_lengths[index].to_i
    app_temp_end_time = app_temp.time + 60*60*app_temp_length
    if (app_temp_end_time <= start_time or end_time <= app_temp.time)
      validator.push(TRUE)
    else
      validator.push(FALSE)
    end
  end

  if validator.all? == FALSE
    puts "
          Please select a different date or time.
         "
  else
    unavailability_temp = []
    unavailability_list.each do |unavailability|
      if unavailability.provider == appointment.provider
        if unavailability.time.month == appointment.time.month
          if unavailability.time.day == appointment.time.day
            unavailability_temp.push(unavailability)
          end
        end
      end
    end

    validator2 = []
    unavailability_temp.each do |unav_temp|
      unav_temp_length = unav_temp.length.to_i
      unav_temp_end_time = unav_temp.time + 60*60*unav_temp_length
      if (unav_temp_end_time <= start_time or end_time <= unav_temp.time)
        validator2.push(TRUE)
      else
        validator2.push(FALSE)
      end
    end

    if validator2.all? == TRUE
      appointment_list.push(appointment)
      puts "
            Your appointment is successfully added!
         "
    else
      puts "
          Please select a different date or time.
         "
    end
  end
end

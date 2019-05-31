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
    puts 'here'
    # @services.select do |service|
    #   if service.name == service_name
    #     @services.delete(service_name)
    #   end
    # end

    for service in @services do
      if service.name == service_name
        @services.delete(service)
      end
    end
    #@services.delete(service_name)
    )
  end

  def printServices()
    puts "#{@name}'s Services:"
    @services.each do |s|
      s.printDetails
    end
  end

  def containsService(name) (
    for service in @services do
      if service.name == name
        return true
      end
    end
    return false
  )
  end

  def serviceAdd(service) (
    @services.push(service)
  )
  end


end
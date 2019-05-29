class ServiceProvider
  attr_reader :name, :phoneNum, :services, :availability, :appointments
  def initialize(name, phoneNum, services, availability, appointments) (
    @name = name
    @phoneNum = phoneNum
    @services = services
    @availability = availability
    @appointments = appointments
  )
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
  # name
  # phoneNum
  # services = []
  # availability = hash{day:[TimeBlocks]}
  # appointments = []
end
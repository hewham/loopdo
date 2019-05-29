
require_relative './service'
require_relative './serviceProvider'
require_relative './appointment'
require_relative './timeblock'

def find_sp_by_service(serviceName, all_sp)
  sp_with_service = []
  for sp in all_sp do
    for s in sp.services do
      if s.name == serviceName
        sp_with_service.push(sp)
        break
      end
    end
  end
  return sp_with_service
end


all_sp = []

temp = Service.new('DEMON HUNTING', 200, 60)

all_sp.push(ServiceProvider.new('Jim', '1111111111', [temp], {}, []))

sp_with_service = find_sp_by_service('DEMON HUNTING', all_sp)

p sp_with_service

# puts temp.name


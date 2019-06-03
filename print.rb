def print_services
    puts
    puts 'SERVICES:'
    puts '---------'
    services = DshsData.instance.services.keys
    services.each do |serv|
        puts serv + '  ---  price: ' + DshsData.instance.services[serv]['price'].to_s + ' , length: ' + DshsData.instance.services[serv]['length'].to_s
    end
    puts
end

def print_service_providers
    puts
    puts 'SERVICE PROVIDERS:'
    puts '------------------'
    service_providers = DshsData.instance.service_providers.keys
    service_providers.each do |sp|
        puts sp + '  ---  services: ' + DshsData.instance.service_providers[sp]['services'].inspect
    end
    puts
end

def print_appointments
    puts
    puts 'APPOINTMENTS:'
    puts '-------------'
    appointments = DshsData.instance.appointments
    appointments.each do |app|
        puts app['service_provider_name'] + ' is providing ' + app['service_name'] + ' for ' + app['client_name'] + ' at ' + app['start_time'].to_s + ' on ' + app['date'].to_s
    end
    puts
end

def print_availability_blocks
    puts
    puts 'AVAILABILITY BLOCKS:'
    puts '--------------------'
    availability_blocks = DshsData.instance.availability_blocks
    availability_blocks.each do |av|
        if av['is_available']
            status = ' available '
        else
            status = ' not available '
        end

        puts av['service_provider_name'] + ' is  ' + status + ' between ' + av['start_time'].to_s + ' and ' + av['end_time'].to_s + ' on ' + av['date'].to_s
    end
    puts
end
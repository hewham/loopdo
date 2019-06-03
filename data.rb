class DshsData
    include Singleton

    def initialize
        # will be initialized with sample data, see data_structure
        @services = {
            "mind reading" => {
                "price" => 3,
                "length" => 2
            },
            "demonic exorcism" => {
                "price" => 4,
                "length" => 4
            },
            "potion therapy" => {
                "price" => 1,
                "length" => 3
            },
            "liver transplants" => {
                "price" => 2,
                "length" => 1
            }
        }
        @service_providers = {
            "jon" => {
                "phone" => 1234567890,
                "services" => ["potion therapy", "liver transplants"],
                "availability" => {
                                    "monday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "tuesday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "wednesday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "thursday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "friday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "saturday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "sunday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true]
                                }
            },
            "daenerys" => {
                "phone" => 2345678901,
                "services" => ["mind reading", "demonic exorcism"],
                "availability" => {
                                    "monday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "tuesday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "wednesday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "thursday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "friday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "saturday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "sunday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true]
                                }
            },
            "arya" => {
                "phone" => 3456789012,
                "services" => ["mind reading", "demonic exorcism", "potion therapy", "liver transplants"],
                "availability" => {
                                    "monday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "tuesday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "wednesday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "thursday" => [true, true, true, true, true, true, true, true, true, true, true, true, false, true, true, true, true, true, true, true, true, true, true, true],
                                    "friday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "saturday" => [false, false, false, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
                                    "sunday" => [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true]
                                }
            }
        }
        @appointments = [
            {
                "date" => 18235,
                "start_time" => 9,
                "service_name" => "mind reading",
                "client_name" => "petyr baelish",
                "service_provider_name" => "arya",
            }
        ]
        @availability_blocks = [
            {
                "service_provider_name" => "arya",
                "date" => 18236,
                "start_time" => 0,
                "end_time" => 7,
                "is_available" => false,
            },
            {
                "service_provider_name" => "arya",
                "date" => 18237,
                "start_time" => 0,
                "end_time" => 3,
                "is_available" => true,
            }
        ]
    end

    attr_accessor :services, :service_providers, :appointments, :availability_blocks

    def add_service(name, price, length)
        # code to add a service to services dictionary
        services[name] = {
            "price" => price,
            "length" => length
        }
        puts "#{name} has successfully been added to services!".colorize(:green ).colorize( :background => :black)

        print_services()
    end

    def remove_service(name)
        # code to remove a service from services dictionary
        services.delete(name)
        puts "#{name} has successfully been removed from services".colorize(:green ).colorize( :background => :black)

        print_services()
    end

    def add_service_provider(name, phone, services, availability)
        # code to add a service provider to service_providers dictionary
        service_providers[name] = {
            "phone" => phone,
            "services" => services,
            "availability" => availability
        }
        puts "#{name} has successfully been added to service providers!".colorize(:green ).colorize( :background => :black)

        print_service_providers()
    end

    def remove_service_provider(name)
        # code to remove a service provider from service_providers dictionary
        service_providers.delete(name)
        puts "#{name} has successfully been removed from service providers".colorize(:green ).colorize( :background => :black)

        print_service_providers()
    end

    def create_appointment(date, start_time, service_name, service_provider_name, client_name)
        # code to add an appointment to the appointments array
        app_new = {
            "date" => date,
            "start_time" => start_time,
            "service_name" => service_name,
            "service_provider_name" => service_provider_name,
            "client_name" => client_name
        }
        @appointments << app_new
        puts 'Your appoinment has been scheduled!'.colorize(:green ).colorize( :background => :black)

        print_appointments()
    end

    def add_availability(name, date, start_time, end_time, is_available)
        app_new = {
            "name" => name,
            "date" => date,
            "start_time" => start_time,
            "end_time" => end_time,
            "is_available" => is_available,
        }
        @availability_blocks << app_new
        puts @availability_blocks.inspect.yellow
        # print_availability_blocks()
    end

    def remove_availability(name,requested_time, start_time, end_time)
        @availability_blocks.delete(name)
        @availability_blocks.delete(requested_time)
        @availability_blocks.delete(start_time)
        @availability_blocks.delete(end_time)
        remove_instance_variable(name) #hopefully gets rid of the entire object
        puts @availability_blocks.inspect.yellow
        # print_availability_blocks()
    end
end
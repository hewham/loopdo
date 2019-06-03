require 'tty-prompt'


def prompt_add_serv
    prompt = TTY::Prompt.new

    name_is_valid = false
    while !name_is_valid do
        name_in = prompt.ask('Service name:')
        if DshsData.instance.services[name_in] == nil
            name_is_valid = true
        else
            puts 'That service already exists! Please choose a different name.'.red
        end
    end

    price_in = prompt.ask('Price (in dollars):').to_i()
    length_in = prompt.ask('Length (in hours):').to_i()

    DshsData.instance.add_service(name_in, price_in, length_in)
end

def prompt_remove_serv
    prompt = TTY::Prompt.new

    name_is_valid = false
    while !name_is_valid do
        name_in = prompt.ask('Service name:')
        if DshsData.instance.services[name_in] != nil
            name_is_valid = true
        else
            puts 'That service does not exist! Please choose a different name.'.red
        end
    end

    DshsData.instance.remove_service(name_in)
end


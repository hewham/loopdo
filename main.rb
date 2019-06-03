require 'tty-prompt'
require_relative 'services'
require_relative 'service_providers'
require_relative 'appointments'
require_relative 'availability'
require_relative 'schedule'
require_relative 'data'
require_relative 'print'



tasks = ['Add service', 'Remove service', 'Add service provider', 'Remove service provider', 'Schedule appointment', 'Create availability block', 'Delete availability block', 'View schedule', 'Exit program']
prompt = TTY::Prompt.new
user_is_done = false

while !user_is_done
    user_task = prompt.select("What would you like to do?", tasks, cycle: true)
    case user_task
    when tasks[0]
        prompt_add_serv()       # call services.rb 'prompt_add'
    when tasks[1]
        prompt_remove_serv()    # call services.rb 'prompt_remove'
    when tasks[2]
        prompt_add_sp()         # call service_providers.rb 'prompt_add'
    when tasks[3]
        prompt_remove_sp()      # call service_providers.rb 'prompt_remove'
    when tasks[4]
        create_app()            # call appointments.rb 'create'
    when tasks[5]
        prompt_add_av()         # call availability.rb 'prompt_add'
    when tasks[6]
        prompt_remove_av()      # call availability.rb 'prompt_remove'
    when tasks[7]
        prompt_view_sch()       # call schedule.rb 'prompt_view'
    when tasks[8]
        user_is_done = true
    else
        puts 'this task does not exist'
        puts
    end
end

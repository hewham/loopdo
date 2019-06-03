menu = {"chicken tenders" => 9.99,
         "cheese burgers" => 2.50,
         "small fries"=> 2.00,
         "ground beef burgers"=> 5.00,
         "ground beef steak" => 19.99
}

# menu.keys.each do |menu|
#   l_name = menu.keys.length
#   l_price = menu.values.length
#   l = l_name + l_price
#   puts l
# end


# puts menu.keys
# puts menu.values

l = menu.map  { |key, value|
                key.length + value.to_s.length}.max + 3


puts menu.map { |key, value|
                key.ljust(l -
                              value.to_s.ljust(4,'0').length , '.') +
                    '$' + value.to_s.ljust(4,'0')}

# menu.keys.each do |item|
#   puts item.ljust(l, '.')
# end
class Appointment2
  def initialize(start_time, length_in_minute)
    @start_time = start_time
    @length_in_minute = length_in_minute
  end

  def instance_variable_test
    @start_time
  end

  def local_variable_test
    start_time
  end
end

appointment = Appointment2.new('2:00', 60)

class Appointment1
  # read info from characters
  attr_reader :start_time, :length_in_minute
  # enable you to rewrite values in these characters
  attr_writer :start_time, :length_in_minute
  # both read and write
  attr_accessor :start_time, :length_in_minute

  def initialize(start_time, length_in_minute)
    @start_time = start_time
    @length_in_minute = length_in_minute
  end

  # instance method, inside this class
  def end_time
    @start_time + @length_in_minute
  end

  def self.shift_forward(appointments)
    appointments.map do |appointment|
      appointment.start_time
    end
  end
end
class Service
  attr_reader :name, :price, :length, :printDetails
  def initialize(name, price, length) (
    @name = name
    @price = price
    @length = length
  )
  end

  def printDetails
    puts "SERVICE: #{@name}, PRICE: $#{@price}, TIME LENGTH: #{@length} Minutes"
  end
end
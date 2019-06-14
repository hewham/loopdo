
class Service
  attr_reader :name, :price, :length, :printDetails
  def initialize(name, price, length) (
    @name = name
    @price = price
    @length = length
  )
  end

  def printDetails
    puts getDetails
    [name,price.to_s, length.to_s]
  end

  def getDetails
    "#{Cyan}#{@name}#{Reset}, #{Green}$#{@price}#{Reset}, #{Yellow}#{@length} Minutes#{Reset}"
  end
end

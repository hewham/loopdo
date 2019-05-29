class Service
  attr_reader :name, :price, :length
  def initialize(name, price, length) (
    @name = name
    @price = price
    @length = length
  )
  end
end
require 'pry'
Kernel.puts("hello world")
class Car
  attr_accessor :brand, :model

  def initialize(new_car)
    @brand = new_car.split(' ').first
    self.model = new_car.split(' ').last
    binding.pry
    p self.brand
  end

end

betty = Car.new('Ford Mustang')
p betty.model.start_with?('M') 

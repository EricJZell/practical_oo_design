# An example of a Gear class with multiple dependencies:
class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end

  def ratio
    chainring / cog.to_f
  end

end

class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + (2 * tire)
  end

end
#The above Gear class has 4 dependencies on the Wheel class:
#1) Gear expects a class named Wheel to exist
#2) Gear expects a wheel instance to respond to 'diameter' method
#3) Gear knows that Wheel.new requires a rim and a tire
#4) Gear knows the 1st argument to Wheel should be 'rim', and the 2nd 'tire'

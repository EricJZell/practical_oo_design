# An example of a Gear class with multiple dependencies:
# class Gear
#   attr_reader :chainring, :cog, :rim, :tire
#   def initialize(chainring, cog, rim, tire)
#     @chainring = chainring
#     @cog = cog
#     @rim = rim
#     @tire = tire
#   end
#
#   def gear_inches
#     ratio * Wheel.new(rim, tire).diameter
#   end
#
#   def ratio
#     chainring / cog.to_f
#   end
#
# end

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

#A better version is as follows, using duck typing
# class Gear
#   attr_reader :chainring, :cog, :wheel
#   def initialize(chainring, cog, wheel)
#     @chainring = chainring
#     @cog = cog
#     @wheel = wheel
#   end
#
#   def gear_inches
#     ratio * wheel.diameter
#   end
#
#   def ratio
#     chainring / cog.to_f
#   end
# end
#Now, wheel does not need to be of class Wheel, it just needs to be a 'Duck'
#that knows the method #diameter
#Gear can now collaborate with any object with the #diameter method
#Another option would be to isolate and expose the dependency within the gear class
#by creating one method that clearly depends on the Wheel class, such as:
# def wheel
#   @wheel ||= Wheel.new(rim, tire)
# end
#Now, the dependency is exposed and isolated.
#Below, re remove the dependency on the order of arguments by using a hash:
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(args)
    @chainring = args.fetch(:chainring, 40)
    @cog = args.fetch(:cog, 18)
    @wheel = args[:wheel]
  end

  def gear_inches
    ratio * wheel.diameter
  end

  def ratio
    chainring / cog.to_f
  end
end
#Now, it doesn't matter what order we call the arguments in:
gear = Gear.new(cog: 12, wheel: Wheel.new(12, 1.5), chainring: 35)
puts gear.ratio
puts gear.gear_inches

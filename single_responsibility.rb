class ObscuringReferences
  #an example of depending on a complicated data structure, which is bad
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def diameters
    #0 is rim, 1 is tire:
    data.collect { |cell|
      cell[0] + (cell[1] * 2)
    }
  end
  #... and many other methods that index into the data array
  # if the structure of the data changes, all the methods would be f!@#ed
end

class RevealingReferences
  #an example where methods don't need knowledge of the data structure, which is good
  attr_reader :wheels
  def initialize(data)
    @wheels = wheelify(data)
  end

  def diameters
    wheels.collect { |wheel| diameter(wheel) }
  end

  def diameter(wheel)
    wheel.rim + (wheel.tire * 2)
  end

  Wheel = Struct.new(:rim, :tire)
  def wheelify(data)
    data.collect { |cell|
      Wheel.new(cell[0], cell[1])
    }
  end
  # now if the data structure changes, only the wheelify method needs to be changed
  # iteration of the wheels array is separated from the action of calculating the diameter
end


class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel=nil)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end

  def circumference
    diameter * Math::PI
  end
end

@wheel = Wheel.new(26, 1.5)
puts @wheel.circumference

puts Gear.new(52, 11, @wheel).gear_inches

puts Gear.new(52, 11).ratio

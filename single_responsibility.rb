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
    wheels.collect { |wheel|
      wheel.rim + (wheel.tire * 2)
    }
  end

  Wheel = Struct.new(:rim, :tire)
  def wheelify(data)
    data.collect { |cell|
      Wheel.new(cell[0], cell[1])
    }
  end
  # now if the data structure changes, only the wheelify method needs to be changed
end


class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * (rim + (tire * 2))
  end
end

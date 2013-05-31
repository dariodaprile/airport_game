require '../lib/weather.rb'

class Airport
  attr_reader :capacity, :planes

  include Weather

  def initialize(capacity =6)
    @capacity = capacity
    @planes = []
  end

  def leave(plane)
    raise "This plane can't take_off" if weather_condition == "stormy"
      planes.delete(plane) if plane.take_off!
  end

  def add(plane)
    raise "This plane can't land" if weather_condition == "stormy"
    planes << plane.land! unless full?
  end

  def full?
    planes.count == capacity
  end

end
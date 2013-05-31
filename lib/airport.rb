require '../lib/weather.rb'

class Airport

  include Weather

  DEFAULT_CAPACITY = 2

  def set_defaults(options = {})
    @capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
  end

  def capacity
    @capacity ||= DEFAULT_CAPACITY
  end

  def request_take_off(plane)
    plane.take_off!
    # planes.each { |plane| plane.take_off!(plane) }
  end

  def leave(plane)
    raise "This plane can't take_off" if weather_condition == "stormy"
      planes.delete(plane)
      plane.take_off!
  end

  def add(plane)
    raise "This plane can't land" if weather_condition == "stormy"
    planes << plane unless full?
    plane.land!
  end

  def full?
    planes.size >= capacity
  end

  def planes
    @plane ||= []
  end

end
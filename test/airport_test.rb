require 'minitest/autorun'
require '../lib/plane.rb'
require '../lib/airport.rb'
require '../lib/weather.rb'

class TestAirport < MiniTest::Unit::TestCase

  def setup
    @airport = Airport.new
    @plane = Plane.new
  end

  # A plane currently in the airport can be requested to take off.
  def test_plane_can_take_off
    @airport.stub :weather_condition, "sunny" do
      @airport.add (@plane)
      puts @airport.planes.count
      @airport.leave(@plane)
      puts @airport.planes.count
      assert_equal "flying", @plane.status
    end
  end

  # No more planes can be added to the airport, if it's full.
  # It is up to you how many planes can land in the airport and how that is impermented.
  def test_no_plane_can_land_if_airport_is_full
    @airport.stub :weather_condition, "sunny" do
      7.times {@airport.add(Plane.new)}
      assert_equal 6, @airport.planes.count
    end
  end

  # If the airport is full then no planes can land
  def test_that_plane_can_land_after_airport_is_full_and_a_take_off_happened
    @airport.stub :weather_condition, "sunny" do
      7.times { @airport.add(Plane.new) }
      assert_equal 6, @airport.planes.count
      @airport.leave(@airport.planes[-1])
      assert @airport.add(@plane)
    end
  end

  # include a weather condition using a module
  # The weather must be random and only have two states "sunny" or "stormy".
  # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
  # This will require stubbing to stop the random return of the weather.
  def test_that_no_plane_can_take_off_with_a_storm_brewing
    @airport.stub :weather_condition, "stormy" do
      assert_raises(RuntimeError) {|plane| @airport.leave(plane)}
    end
  end

  # grand final
  # Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
  # Be careful of the weather, it could be stormy!
  # Check when all the planes have landed that they have the right status "landed"
  # Once all the planes are in the air again, check that they have the status of flying!
  def test_all_planes_can_land_then_all_planes_in_airport_can_takeoff
    @airport.stub :weather_condition, "sunny" do
      6.times { @airport.add(Plane.new)}
      puts @airport.planes.count
      @airport.planes.each {|plane| assert_equal "landed", plane.status}
      puts @airport.planes.count
      @airport.planes.each {|plane| @airport.leave(plane)}
      puts @airport.planes.count
      assert_equal 0, @airport.planes.count

  end
end
end
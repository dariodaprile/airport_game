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
      @plane.land!
      assert_equal "landed", @plane.status
      @airport.request_take_off(@plane)
      assert_equal "flying", @plane.status
    end
  end

  # No more planes can be added to the airport, if it's full.
  # It is up to you how many planes can land in the airport and how that is impermented.
  def test_no_plane_can_land_if_airport_is_full
    @airport.stub :weather_condition, "sunny" do
      plane1= Plane.new
      plane1.land!
      @airport.add(plane1)

      plane2= Plane.new
      plane2.land!
      @airport.add(plane2)

      plane3= Plane.new
      plane3.land!
      @airport.add(plane3)

      assert_equal 2, @airport.planes.count
    end
  end

  # If the airport is full then no planes can land
  def test_that_plane_can_land_after_airport_is_full_and_a_take_off_happened
    @airport.stub :weather_condition, "sunny" do

      plane1= Plane.new
      plane1.land!
      @airport.add(plane1)

      plane2= Plane.new
      plane2.land!
      @airport.add(plane2)

      plane3= Plane.new

      assert @airport.full?

      plane2.take_off!
      @airport.leave(plane2)

      assert @airport.add(plane3)
    end
  end

  # include a weather condition using a module
  # The weather must be random and only have two states "sunny" or "stormy".
  # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
  # This will require stubbing to stop the random return of the weather.
  def test_that_no_plane_can_take_off_with_a_storm_brewing
    @airport.stub :weather_condition, "stormy" do
      assert_raises(RuntimeError) do
        @airport.leave(@plane)
      end
    end
  end


  # grand final
  # Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
  # Be careful of the weather, it could be stormy!
  # Check when all the planes have landed that they have the right status "landed"
  # Once all the planes are in the air again, check that they have the status of flying!
  def test_all_planes_can_land_then_all_planes_in_airport_can_takeoff
    @airport.stub :weather_condition, "sunny" do
      plane1= Plane.new
      plane1.land!
      @airport.add(plane1)

      plane2= Plane.new
      plane2.land!
      @airport.add(plane2)

      plane3= Plane.new
      plane3.land!
      @airport.add(plane3)

      plane4= Plane.new
      plane4.land!
      @airport.add(plane4)

      plane5= Plane.new
      plane5.land!
      @airport.add(plane5)

      plane6= Plane.new
      plane6.land!
      @airport.add(plane6)
    end

    assert @airport.full?
    @airport.planes.each do |plane|
      assert_equal "landed", plane.status
    end

    @airport.planes.each do |plane|
      @airport.stub :weather_condition, "sunny" do
        @airport.leave(plane)
        assert_equal "flying", plane.status
      end
    end

  end

end
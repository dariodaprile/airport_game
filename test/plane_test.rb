require "minitest/autorun"
require '../lib/plane.rb'

class TestAirplane < MiniTest::Unit::TestCase

  def setup
    @plane = Plane.new
  end

  def test_plane_can_land
    @plane.land!
    assert_equal "landed", @plane.status
  end

# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport
  def test_plane_has_a_flying_status_after_it_is_created
    assert_equal "flying", @plane.status
  end

# When we land a plane at the airport, the plane in question should have its status changed to "landed"
  def test_plane_has_a_landed_status_after_landing
    @plane.land!
    assert_equal "landed", @plane.status
  end

  # When the plane takes of from the airport, the plane's status should become "flying"
  def test_plane_has_a_flying_status_after_take_off
    @plane.take_off!
    assert_equal "flying", @plane.status
  end
end
class Plane

attr_accessor :status

  def initialize
    @status = "flying"
    @flying
  end

  def flying?
    @flying
  end

  def land!
    @flying = false
    @status = "landed"
  end

  def take_off!
    @flying = true
    @status = "flying"
  end
end
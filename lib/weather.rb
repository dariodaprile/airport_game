module Weather

  def weather_condition
    @weather = rand(10) > 3 ?  "sunny" : "stormy"
  end
end


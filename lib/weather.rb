module Weather

def weather_condition
  a = rand(10)
  if a > 3
    @weather = "sunny"
  else
    @weather = "stormy"
  end
end

end


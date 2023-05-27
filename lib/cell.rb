class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
  end

  def empty?
    !@ship
  end

  def place_ship(cruiser)
    @ship = cruiser
  end

  def fired_upon?
    @ship.health != @ship.length
  end

  def fire_upon
    @ship.hit
  end

  def render
    if 
      "."
    elsif fired_upon? && empty?
      "M"
    end
  end
end
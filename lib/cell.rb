class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil 
    @cell_fired_upon = false
  end

  def empty?
    !@ship
  end

  def place_ship(new_ship)
    @ship = new_ship
  end

  def fired_upon?
    @cell_fired_upon
  end

  def fire_upon
    @cell_fired_upon = true
    if @ship 
      @ship.hit
    end
  end

  def render(show = false)
    if show == true && !empty?
      "S"
    elsif !fired_upon?
      "."
    elsif fired_upon? && empty?
      "M"
    elsif fired_upon? && !empty? && @ship.sunk? == false
      "H"
    else fired_upon? && @ship.sunk?
      "X"
    end
  end
end
require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  describe 'Class' do
    it 'exists and has readable attributes' do
      cell = Cell.new("B4")
      expect(cell).to be_a(Cell)
      expect(cell.coordinate).to eq("B4")
      expect(cell.ship).to eq(nil)
    end

    it 'can check if it is empty' do
      cell = Cell.new("B4")
      expect(cell.empty?).to eq true
    end

    it 'can store a ship object' do
      cell = Cell.new("B4")
      expect(cell.empty?).to eq true

      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      expect(cell.ship).to eq(cruiser)
      expect(cell.empty?).to eq false
    end

    it 'knows when its fired upon' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.fired_upon?).to eq false
      cell.fire_upon
      expect(cell.ship.health).to eq(2)
      expect(cell.fired_upon?).to eq true
    end
  end 

# ——————————— RENDER ——————————

  describe "Class" do
    it 'can render .' do
      cell_1 = Cell.new("B4")
      require 'pry'; binding.pry
      expect(cell_1.render).to eq(".")
      cell_1.fire_upon
      expect(cell_1.render).to eq("M")
    end
  end
end
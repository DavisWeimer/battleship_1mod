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
    it 'can render . and M' do
      cell_1 = Cell.new("B4")
      expect(cell_1.render).to eq(".")
      cell_1.fire_upon
      expect(cell_1.render).to eq("M")
      
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      
      cell_2.place_ship(cruiser)
      cell_2.render
      expect(cell_2.ship).to eq(cruiser)
      expect(cell_2.render).to eq(".")
    end

    it 'can render S' do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      expect(cell_2.render).to eq(".")
      expect(cell_2.render(true)).to eq(".")
      cell_2.place_ship(cruiser)
      expect(cell_2.render(true)).to eq("S")
    end

    it 'can render H when ship hit and X when ship sunk' do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      expect(cell_2.render).to eq(".")
      cell_2.fire_upon
      expect(cell_2.render).to eq("H")
      expect(cruiser.sunk?).to eq(false)
      cruiser.hit
      expect(cruiser.health).to eq(1)
      cruiser.hit
      expect(cruiser.sunk?).to eq(true)
      expect(cell_2.render).to eq("X")
    end
  end
end
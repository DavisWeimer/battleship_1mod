require './lib/board'
require './lib/ship'

RSpec.describe Board do
  describe 'class' do
    it 'exists' do
      board = Board.new
      expect(board).to be_a(Board)
    end

    it 'has cells' do
      board = Board.new
      expect(board.cells).to be_a(Hash)
      expect(board.cells.count).to eq(16)
    end
  end
  describe 'coordinates' do
    it 'can validate passed in coordinate' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      expect(board.valid_coordinate?("A1")).to eq true
      expect(board.valid_coordinate?("D4")).to eq true
      expect(board.valid_coordinate?("A5")).to eq false
      expect(board.valid_coordinate?("E1")).to eq false
      expect(board.valid_coordinate?("A22")).to eq false

      board.cells["A1"].fire_upon
      board.cells["D4"].fire_upon

      expect(board.valid_coordinate?("A1")).to eq false
      expect(board.valid_coordinate?("D4")).to eq false
    end

    it 'can validate ship placement only equal to length' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq false
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq false
      expect(board.valid_placement?(cruiser, ["A1", "B1", "C1"])).to eq true
      expect(board.valid_placement?(submarine, ["C2", "C3"])).to eq true
    end

    it 'can validate ship placement if coordinates are consecutive vertically and horizontally' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq false
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq false
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq false
      expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq false
      expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq true
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq true
    end

    it 'cannot validate diagonal placement' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq false
      expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq false
    end
  end

  describe 'placement' do
    it 'can put ships on the board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      board.place(cruiser, ["A1", "A2", "A3"])

      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      expect(cell_1.ship).to eq(cruiser)
      expect(cell_2.ship).to eq(cruiser)
      expect(cell_3.ship).to eq(cruiser)
      expect(cell_1.ship == cell_2.ship).to eq true
      expect(cell_3.ship == cell_2.ship).to eq true
    end

    it 'cannot validate overlapped ships' do 
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      board.place(cruiser, ["A1", "A2", "A3"])

      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq false
    end
  end

  describe 'render' do
    it 'can render a string representation of itself to display cells in formatted grid' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3) 
      submarine = Ship.new("Submarine", 2)
      
      board.place(cruiser, ["A1", "A2", "A3"]) 
      board.place(submarine, ["C3", "D3"])
      expect(board.render).to eq ("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
      expect(board.render(true)).to eq ("  1 2 3 4 \nA S S S . \nB . . . . \nC . . S . \nD . . S . \n")

      board.cells["A1"].fire_upon
      board.cells["B4"].fire_upon
      board.cells["C3"].fire_upon
      board.cells["D3"].fire_upon
      
      expect(board.render).to eq ("  1 2 3 4 \nA H . . . \nB . . . M \nC . . X . \nD . . X . \n")

    end
  end
end
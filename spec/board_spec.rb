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
      expect(board.valid_coordinate?("A1")).to eq true
      expect(board.valid_coordinate?("D4")).to eq true
      expect(board.valid_coordinate?("A5")).to eq false
      expect(board.valid_coordinate?("E1")).to eq false
      expect(board.valid_coordinate?("A22")).to eq false
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

    it 'can validate ship placement if coordinates are consecutive' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq false
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq false
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq false
      expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq false
    end
  end
end
require './lib/board'

RSpec.describe Board do
  describe Board do
    it 'exists' do
      board = Board.new
      expect(board).to be_a(Board)
    end

    it 'has cells' do
      board = Board.new
      expect(board.cells).to be_a(Hash)
      expect(board.cells.count).to eq(16)
    end

    it 'can validate coordinates' do
      board = Board.new
      expect(board.valid_coordinate?("A1")).to eq(true)
      expect(board.valid_coordinate?("D4")).to eq(true)
      expect(board.valid_coordinate?("A5")).to eq(false)
      expect(board.valid_coordinate?("E1")).to eq(false)
      expect(board.valid_coordinate?("A22")).to eq(false)
    end
  end
end
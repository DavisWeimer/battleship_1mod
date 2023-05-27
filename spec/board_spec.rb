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
      board.valid_coordinate?("A1").to eq(true)
    end
  end
end
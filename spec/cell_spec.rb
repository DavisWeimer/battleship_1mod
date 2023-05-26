require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  it 'exists and has readable attributes' do
    cell = Cell.new("B4")
    expect(cell).to be_a(Cell)
    expect(cell.coordinate).to eq("B4")
    expect(cell.ship).to eq(nil)
  end

end
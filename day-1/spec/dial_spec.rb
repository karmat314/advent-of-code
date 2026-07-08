require './dial'
require './custom_error'

RSpec.describe Dial do
  let(:dial) { described_class.new(max_val: 99, curr_val: 50) }

  context 'creation' do
    it 'returns a Dial object' do
      expect(dial).to be_instance_of(Dial)
    end

    it 'has correct default values' do
      expect(dial.max_val).to eq(99)
      expect(dial.curr_val).to eq(50)
    end

    it 'raises error on invalid arguments' do
      expect { described_class.new(max_val: -20) }.to raise_error(CustomError)
      expect { described_class.new(curr_val: -20) }.to raise_error(CustomError)
      expect { described_class.new(curr_val: 100) }.to raise_error(CustomError)
    end
  end

  context 'rotation' do
    it 'rotates to correct position' do
      dial.rotate(rotation: 'R10')
      expect(dial.curr_val).to eq(60)
    end

    it 'rotates circularly for rotations exceeding max_value' do
      dial.rotate(rotation: 'R50')
      expect(dial.curr_val).to eq(0)
    end

    it 'increments zero counter when dial lands at zero' do
      before = dial.zero_count
      dial.rotate(rotation: 'R50')
      expect(dial.zero_count).to eq(before + 1)
    end
  end
end

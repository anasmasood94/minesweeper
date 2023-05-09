RSpec.describe GridGenerator do
  describe '#call' do
    context 'with valid attributes' do
      let(:height) { 5 }
      let(:width) { 5 }
      let(:number_of_mines) { 5 }
      let(:grid) { GridGenerator.call(height, width, number_of_mines) }

      it 'returns a 5x5 grid' do
        expect(grid.size).to eq(height)
        expect(grid.first.size).to eq(width)
      end

      it 'contains the correct number of mines' do
        mines_count = grid.flatten.count(-1)
        expect(mines_count).to eq(number_of_mines)
      end

      it 'contains only -1 and 0 values' do
        valid_values = [-1, 0]
        values = grid.flatten.uniq
        expect(values).to match_array(valid_values)
      end
    end

    context 'with invalid number of mines' do
      let(:height) { 5 }
      let(:width) { 5 }
      let(:number_of_mines) { 30 }

      it 'raises an error' do
        expect { GridGenerator.call(height, width, number_of_mines) }.to raise_error(ArgumentError)
      end
    end

    context 'with small boards' do
      it 'generates 50 mines in less than 1 second' do
        expect { GridGenerator.call(10, 10, 50) }.to perform_under(1).sec
      end
    end

    context 'with medium boards' do
      it 'generates 9995 mines in less than 1 second' do
        expect { GridGenerator.call(100, 100, 9995) }.to perform_under(1).sec
      end
    end

    context 'with big boards' do
      it 'generates 500000 mines in less than 1 second' do
        expect { GridGenerator.call(1000, 1000, 500000) }.to perform_under(1).sec
      end
    end
  end
end

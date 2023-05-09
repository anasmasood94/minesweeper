RSpec.describe Board, type: :model do
  describe 'validations' do
     it 'validates presence of name' do
      board = FactoryBot.build(:board, name: nil, height: 5, width: 5, number_of_mines: 10)
      expect(board.valid?).to be false
    end

    it 'validates presence of email' do
      board = FactoryBot.build(:board, name: "test", email: nil, height: 5, width: 5, number_of_mines: 10)
      expect(board.valid?).to be false
    end

    it 'validates numericality of width is greater than 0' do
      board = FactoryBot.build(:board, name: "test", email: "hello@test.com", height: 5, width: -1, number_of_mines: 10)
      expect(board.valid?).to be false
    end

    it 'validates numericality of height is greater than 0' do
      board = FactoryBot.build(:board, name: "test", email: "hello@test.com", height: -1, width: 5, number_of_mines: 10)
      expect(board.valid?).to be false
    end

    it 'validates numericality of number of mines is greater than 0' do
      board = FactoryBot.build(:board, name: "test", email: "hello@test.com", height: -1, width: 5, number_of_mines: 0)
      expect(board.valid?).to be false
    end

    context 'when the number of mines exceeds the possible value for given board' do
      let(:board) { FactoryBot.build(:board, width: 5, height: 5, number_of_mines: 50) }

      it 'should return an error for number_of_mines field' do
        board.valid?
        expect(board.errors[:number_of_mines]).to include('Number of mines are greater then the possible value for given board')
      end
    end
  end

  describe 'callbacks' do
    context 'before create' do
      let(:board) { FactoryBot.build(:board, width: 8, height: 8, number_of_mines: 10) }

      it 'should generate a grid' do
        expect(GridGenerator).to receive(:call).with(8, 8, 10)
        board.save
      end
    end
  end

  describe 'methods' do
    describe '#number_of_mines_possible_in_grid' do
      context 'when the number of mines exceeds the possible value for given board' do
        let(:board) { FactoryBot.build(:board, width: 5, height: 5, number_of_mines: 50) }
        let(:board_1) { FactoryBot.build(:board, width: 1000, height: 1000, number_of_mines: 5000000) }

        it 'should add an error to the errors array' do
          board.send(:number_of_mines_possible_in_grid)
          board_1.send(:number_of_mines_possible_in_grid)

          expect(board.errors[:number_of_mines]).to include('Number of mines are greater then the possible value for given board')
          expect(board_1.errors[:number_of_mines]).to include('Number of mines are greater then the possible value for given board')
        end
      end

      context 'when the number of mines is within the possible value for given board' do
        let(:board) { FactoryBot.build(:board, width: 5, height: 5, number_of_mines: 5) }
        let(:board_1) { FactoryBot.build(:board, width: 10, height: 10, number_of_mines: 50) }
        let(:board_2) { FactoryBot.build(:board, width: 100, height: 100, number_of_mines: 995) }


        it 'should not add any error to the errors array' do
          board.send(:number_of_mines_possible_in_grid)
          board_1.send(:number_of_mines_possible_in_grid)
          board_2.send(:number_of_mines_possible_in_grid)

          expect(board.errors).to be_empty
          expect(board_1.errors).to be_empty
          expect(board_2.errors).to be_empty
        end
      end
    end
  end
end

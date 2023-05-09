RSpec.describe BoardsController, type: :request do
  describe 'GET #index' do
    it 'renders the index template' do
      get boards_path

      expect(response).to render_template(:index)
    end

    it 'assigns @boards' do
      boards = FactoryBot.create_list(:board, 3)
      get boards_path
      expect(assigns(:boards)).to eq(boards)
    end

    it 'limits @boards to 10 if @show_all is false' do
      FactoryBot.create_list(:board, 11)
      get boards_path
      expect(assigns(:boards).count).to eq(10)
    end

    it 'does not limit @boards if @show_all is true' do
      FactoryBot.create_list(:board, 11)
      get boards_path, params: { all: true }
      expect(assigns(:boards).length).to eq(11)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get root_path
      expect(response).to render_template(:new)
    end

    it 'assigns a new board to @board' do
      get root_path
      expect(assigns(:board)).to be_a_new(Board)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new board' do
        expect {
          post boards_path, params: { board: FactoryBot.attributes_for(:board) }
        }.to change(Board, :count).by(1)
      end

      it 'redirects to the new board' do
        post boards_path, params: { board: FactoryBot.attributes_for(:board) }
        expect(response).to redirect_to(assigns(:board))
      end

      it 'sets a success flash message' do
        post boards_path, params: { board: FactoryBot.attributes_for(:board) }
        expect(flash[:success]).to eq('Board saved successfully')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new board' do
        expect {
          post boards_path, params: { board: FactoryBot.attributes_for(:board, name: nil) }
        }.not_to change(Board, :count)
      end

      it 'renders the new template' do
        post boards_path, params: { board: FactoryBot.attributes_for(:board, name: nil) }
        expect(response).to redirect_to(assigns(:board))
      end

      it 'sets an alert flash message' do
        post boards_path, params: { board: FactoryBot.attributes_for(:board, name: nil) }
        expect(flash[:alert]).to eq('Name can\'t be blank')
      end
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      board = FactoryBot.create(:board)
      get board_path(board.id), params: { id: board.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the requested board to @board' do
      board = FactoryBot.create(:board)
      get board_path(board.id), params: { id: board.id }
      expect(assigns(:board)).to eq(board)
    end
  end
end

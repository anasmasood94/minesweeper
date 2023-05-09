# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :set_show_all, only: :index

  def index
    @boards = Board.select(:id, :name, :email, :width, :height, :number_of_mines, :created_at)
    @boards = @boards.limit(10) unless @show_all
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      flash[:success] = 'Board saved successfully'
    else
      flash[:alert] = @board.errors.count > 0 ? @board.errors.full_messages.join("<br />").html_safe : 'Unable to save the form'
    end

    redirect_to @board
  end

  def show
    @board = Board.find(params[:id])
  end

  private

  def board_params
    params.require(:board).permit(:name, :email, :width, :height, :number_of_mines)
  end

  def set_show_all
    @show_all = params[:all] == "true"
  end
end

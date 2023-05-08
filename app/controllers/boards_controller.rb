# frozen_string_literal: true

class BoardsController < ApplicationController
  def new
    @board = Board.new
  end

  def create
    board = Board.new(board_params)
    if board.save
      flash[:success] = 'Board saved successfully'
    else
      flash[:alert] = board.errors.count > 0 ? board.errors.full_messages.join("<br />").html_safe : 'Unable to save the form'
    end

    @board = Board.new
    render :new
  end

  def show
    @board = Board.find(params[:id])
  end

  private

  def board_params
    params.require(:board).permit(:name, :email, :width, :height, :number_of_mines)
  end
end

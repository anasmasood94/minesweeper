# frozen_string_literal: true

class Board < ApplicationRecord
  validates_presence_of :name, :email, :width, :height, :number_of_mines
  validates_numericality_of :width, greater_than: 0
  validates_numericality_of :height, greater_than: 0
  validates_numericality_of :number_of_mines, greater_than: 0

  validate :number_of_mines_possible_in_grid

  before_create :generate_gird

  private

  def number_of_mines_possible_in_grid
    return if number_of_mines <= height * width

    errors.add(:number_of_mines, 'Number of mines are greater then the possible value for given board')
  end

  def generate_gird
    self.grid = GridGenerator.call(height, width, number_of_mines)
  end
end

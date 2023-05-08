class GridGenerator

  def self.call(height, width, number_of_mines)
    new(height, width, number_of_mines).perform
  end

  def initialize(height, width, number_of_mines)
    @height = height
    @width = width
    @number_of_mines = number_of_mines
  end

  def perform
    board_grid = Array.new(@height) { Array.new(@width, 0) }
    mines_generated = 0

    while mines_generated < @number_of_mines
      x = rand(@width)
      y = rand(@height)

      next if board_grid[y][x] == -1

      board_grid[y][x] = -1
      mines_generated += 1
    end

    board_grid
  end
end

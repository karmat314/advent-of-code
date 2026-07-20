# frozen_string_literal: true

class RollCounter
  attr_reader :roll_lines, :roll_grid, :roll_count

  def initialize
    @roll_lines = File.readlines('./input.txt', chomp: true)
    @roll_grid = []
    @roll_count = 0
    make_grid
  end

  def get_adjacent_roll_count
    grid = @roll_grid
    removable_roll_indices = []
    removable_roll_count = 0

    (0...grid.length).each do |row|
      (0...grid[0].length).each do |col|
        next unless grid[row][col] == '@'

        adjacent_roll_count = 0
        ((row - 1)..(row + 1)).each do |i|
          ((col - 1)..(col + 1)).each do |j|
            next if i.negative? || j.negative?
            next if (i == row) && (j == col)
            next if grid[i]&.[](j).nil?

            adjacent_roll_count += 1 if grid[i][j] == '@'
          end
        end

        if adjacent_roll_count < 4
          removable_roll_count += 1
          removable_roll_indices << [row, col]
        end
      end
    end

    [removable_roll_count, removable_roll_indices]
  end

  def remove_rolls(indices)
    indices.each do |pair|
      @roll_grid[pair[0]][pair[1]] = '.'
    end
  end

  def get_total_removable_rolls
    while true
      removable_roll_count, removable_roll_indices = get_adjacent_roll_count
      break if removable_roll_count == 0

      @roll_count += removable_roll_count

      remove_rolls(removable_roll_indices)
    end
  end

  private

  def make_grid
    @roll_lines.each do |line|
      @roll_grid << line.chars
    end
  end
end

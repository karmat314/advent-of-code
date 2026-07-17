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
    (0...grid.length).each do |row|
      (0...grid[0].length).each do |col|
        next unless grid[row][col] == '@'

        adjacent_roll_count = 0
        ((row - 1)..(row + 1)).each do |i|
          ((col - 1)..(col + 1)).each do |j|
            next if i.negative? || j.negative?
            next if (i == row) && (j == col)
            next if grid[i]&.[](j).nil?

            adjacent_roll_count += grid[i][j] == '@' ? 1 : 0
          end
        end
        @roll_count += adjacent_roll_count < 4 ? 1 : 0
      end
    end
  end

  private

  def make_grid
    @roll_lines.each do |line|
      @roll_grid << line.chars
    end
  end
end

require_relative './custom_error'

class Dial
  attr_reader :min_val, :max_val, :curr_val, :zero_count

  def initialize(max_val: 99, curr_val: 50)
    raise CustomError if max_val < 0 or curr_val < 0
    raise CustomError if curr_val > max_val

    @min_val = 0
    @max_val = max_val
    @curr_val = curr_val
    @zero_count = 0
  end

  def rotate(rotation:)
    # rotation ex: 'L20', 'R5', ...
    # L = left, R'= right
    rotationVal = rotation[1..].to_i
    rotationVal = -rotationVal if rotation[0] == 'L'
    @curr_val = (@curr_val + rotationVal) % 100

    return unless @curr_val == 0

    @zero_count += 1
  end

  def perform_rotation_sequence(file_path)
    return unless file_path

    rotations = File.readlines(file_path, chomp: true)
    rotations.each do |rotation|
      rotate(rotation:)
    end
  end

  def password
    @zero_count
  end
end

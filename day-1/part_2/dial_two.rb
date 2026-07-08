require_relative '../dial_behaviour'

class DialTwo
  include DialBehavior

  attr_reader :zero_pass_count

  def initialize(max_val: 99, curr_val: 50)
    super
    @zero_pass_count = 0
  end

  def count_zero_passes(rotation:)
    rotation_val = rotation[1..].to_i
    direction = rotation[0]

    if direction == 'R'
      low  = @curr_val + 1
      high = @curr_val + rotation_val
    else # 'L'
      low  = @curr_val - rotation_val
      high = @curr_val - 1
    end

    passes = (high / 100) - ((low - 1) / 100)
    @zero_pass_count += passes

    rotate(rotation: rotation)
    passes
  end

  def count_zero_passes_in_rotation_sequence(file_path)
    return unless file_path

    rotations = File.readlines(file_path, chomp: true)
    rotations.each do |rotation|
      count_zero_passes(rotation: rotation)
    end
  end

  def get_zero_passes
    @zero_pass_count
  end
end

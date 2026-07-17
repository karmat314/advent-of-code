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
    rotation_val = -rotation_val if rotation[0] == "L"
    rotation_val.abs.times do
      if rotation[0] == "L"
        @curr_val -= 1
    else
        @curr_val += 1
      end
      if @curr_val > max_val
        @curr_val = 0
      elsif @curr_val < min_val
        @curr_val = 99
      end
      @zero_pass_count += @curr_val == 0 ? 1 : 0
    end
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

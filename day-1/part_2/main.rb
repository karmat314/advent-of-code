require_relative './dial_two'
class DialCracker
  def get_password
    dial_one = DialTwo.new
    dial_two = DialTwo.new
    dial_one.perform_rotation_sequence('../input.txt')
    dial_two.count_zero_passes_in_rotation_sequence('../input.txt')
    dial_two.get_zero_passes - dial_one.get_password
  end
end

puts DialCracker.new.get_password

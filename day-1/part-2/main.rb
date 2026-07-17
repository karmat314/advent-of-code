require_relative './dial_two'
class DialCracker
  def get_password
    dial = DialTwo.new
    dial.count_zero_passes_in_rotation_sequence('../input.txt')
  puts dial.get_zero_passes
  end
end

DialCracker.new.get_password

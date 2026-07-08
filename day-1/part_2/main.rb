require_relative '../dial'

class DialCracker
  def get_password
    dial = Dial.new
    dial.perform_rotation_sequence('input.txt')
    dial.password
  end
end

puts DialCracker.new.get_password

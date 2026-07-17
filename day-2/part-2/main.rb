# frozen_string_literal: true

require_relative '../id_checker'

class IdAdder
  def get_sum
    id_checker = IdChecker.new
    id_checker.check_ids_repeated_substrings
    id_checker.sum
  end
end

puts IdAdder.new.get_sum

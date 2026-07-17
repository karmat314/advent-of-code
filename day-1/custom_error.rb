# frozen_string_literal: true

class CustomError < StandardError
  def initialize(msg = 'Something happened...')
    super
  end
end

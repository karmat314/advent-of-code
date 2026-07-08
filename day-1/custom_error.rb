class CustomError < StandardError
  def initialize(msg = 'Something happened...')
    super(msg)
  end
end

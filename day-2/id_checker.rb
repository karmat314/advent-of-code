class IdChecker
  attr_reader :id_ranges, :invalid_ids

  def initialize
    @id_ranges = File.readlines('../valid_ids.txt', chomp: true)
    @invalid_ids = []
    extract_ranges
  end

  def check_ids
    @id_ranges.each do |id|
      arr = id.to_s.split('')
      half = arr.size / 2
      left  = arr.take(half)
      right = arr.drop(half)

      @invalid_ids << id if left == right
    end
  end

  def check_ids_repeated_substrings
    @id_ranges.each do |id|
      str_appended = (id.to_s + id.to_s)[1..-2]
      @invalid_ids << id if str_appended.include?(id.to_s)
    end
  end

  def sum
    @invalid_ids.sum
  end

  private

  def extract_ranges
    unformatted_ranges = @id_ranges.join('').split(',')
    formatted = []
    unformatted_ranges.each do |range|
      split_range = range.split('-').map(&:to_i)
      formatted << (split_range[0]..split_range[1]).to_a
    end

    @id_ranges = formatted.flatten
  end
end

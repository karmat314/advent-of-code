# frozen_string_literal: true

class IngredientFilter
  attr_reader :available_ingredients, :fresh_id_ranges, :raw_db, :fresh_ids, :seen

  def initialize
    @raw_db = File.read('./input.txt').gsub("\r\n", "\n").split(/\n{2,}/)
    @available_ingredients = @raw_db[1].strip.split("\n").map(&:to_i)
    @fresh_id_ranges = @raw_db[0].strip.split("\n").map { |raw_range| get_ranges(raw_range) }
    @seen = {}
  end

  def count_fresh_ingredients
    count = 0
    @available_ingredients.each do |ingredient|
      @fresh_id_ranges.each do |range|
        next if @seen.key?(ingredient)

        if range.include?(ingredient)
          count += 1
          @seen[ingredient] = 1
        end
      end
    end
    count
  end

  def check_fresh_range_count
    sorted_ranges = @fresh_id_ranges.sort_by(&:begin)
    puts sorted_ranges
    merged = []
    merged << sorted_ranges[0]
    sorted_ranges.each do |range|
      if merged.last.end >= range.begin
        last_range = merged.pop
        merged << (last_range.begin..[last_range.end, range.end].max)
      else
        merged << range
      end
      puts merged
    end
    merged.reduce(0) { |count, range| count + (range.end - range.begin + 1) }
  end

  private

  def get_ranges(raw_range)
    range_bounds = raw_range.split('-').map(&:to_i)
    (range_bounds[0]..range_bounds[1])
  end

  def merge_range(range_one, range_two)
    (range_one.first..range_two.last)
  end
end

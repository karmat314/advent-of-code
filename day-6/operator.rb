class Operator
  attr_reader :raw, :numbers, :operations

  def initialize
    @raw = File.readlines('./input.txt', chomp: true)
    @numbers = []
    @operations = []
    format
    transpose
  end

  def operate
    total = 0
    @numbers.each_with_index do |number_row, index|
      total += if @operations[index] == '+'
                 number_row.sum
               else
                 number_row.inject(:*)
               end
    end
    total
  end

  def operate_cephalopodically
    no_of_lines = @raw.length - 1
    transformed_numbers = []
    final_numbers = []
    (0...@raw[0].length).each do |i|
      temp = ''
      (0...no_of_lines).each do |j|
        temp += @raw[j][i]
      end
      transformed_numbers << temp
    end

    arr = []
    transformed_numbers.each_with_index do |num, index|
      if num.strip.empty?
        final_numbers << arr
        arr = []
      else
        arr << num.strip
        final_numbers << arr if index == transformed_numbers.length - 1
      end
    end

    final_numbers = final_numbers.map { |sub_array| sub_array.map(&:to_i) }
    total = 0
    final_numbers.each_with_index do |num, index|
      total += if @operations[index] == '+'
                 num.sum
               else
                 num.inject(:*)
               end
    end
    total
  end

  private

  def format
    @raw[...-1].each do |line|
      @numbers << line.split(' ').map(&:to_i)
    end
    @operations = @raw[-1].split(' ')
  end

  def transpose
    @numbers = @numbers.transpose
  end
end

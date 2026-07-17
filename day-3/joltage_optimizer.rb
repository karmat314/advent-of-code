# frozen_string_literal: true

class JoltageOptimizer
  attr_reader :max_jolts

  def initialize
    @battery_banks = File.readlines('./input.txt', chomp: true)
    @max_jolts = []
  end

  def find_max_joltage
    @battery_banks.each do |bank|
      bank_jolts = bank.chars.map(&:to_i)
      max_jolt_one, index = bank_jolts[0...-1].each_with_index.max_by { |value, _index| value }
      max_jolt_two = 0
      ((index + 1)...bank_jolts.length).each do |i|
        max_jolt_two = [max_jolt_two, bank_jolts[i]].max
      end
      @max_jolts << (max_jolt_one.to_s + max_jolt_two.to_s).to_i
    end
  end

  def find_max_joltage_select_12
    @battery_banks.each do |bank|
      need = 12
      selected_jolts = []
      bank_jolts = bank.chars.map(&:to_i)
      until bank_jolts.empty?
        max_jolt, index = bank_jolts[0..(bank_jolts.length - need)].each_with_index.max_by { |value, _index| value }
        selected_jolts << max_jolt
        bank_jolts = bank_jolts[(index + 1)..]
        need -= 1
        break if need.zero?
      end
      @max_jolts << selected_jolts.join.to_i
    end
  end

  def get_sum
    @max_jolts.sum
  end
end

class JoltageOptimizer
  attr_reader :max_jolts

  def initialize
    @battery_banks = File.readlines('../input.txt', chomp: true)
    puts @battery_banks
    @max_jolts = []
  end

  def find_max_joltage
    @battery_banks.each do |bank|
      bank_jolts = bank.chars.map(&:to_i)
      max_jolt_one, index = bank_jolts[0...-1].each_with_index.max_by { |value, _index| value }
      puts max_jolt_one
      max_jolt_two = 0
      for i in ((index + 1)...bank_jolts.length)
        max_jolt_two = [max_jolt_two, bank_jolts[i]].max
      end
      @max_jolts << (max_jolt_one.to_s + max_jolt_two.to_s).to_i
    end
  end

  def get_sum
    @max_jolts.sum
  end
end

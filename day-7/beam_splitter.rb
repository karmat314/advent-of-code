class BeamSplitter
  attr_reader :tachyon_lines, :split_count

  def initialize
    @tachyon_lines = File.readlines('./input.txt', chomp: true).map { |line| line.split('') }
    @beam_locations = Hash.new { |hash, key| hash[key] = [] }
    @split_count = 0
    init_beam
  end

  def traverse_tachyon_manifold
    @tachyon_lines.each_with_index do |_line, index|
      split_beam(index)
    end
    @tachyon_lines.map { |line| line.join('') }
  end

  private

  def init_beam
    @tachyon_lines[1][@tachyon_lines[0].index('S')] = '|'
    @beam_locations[1] = [@tachyon_lines[0].index('S')]
  end

  def split_beam(index)
    return if @beam_locations.empty?

    @tachyon_lines[index].each_with_index do |part, idx|
      @tachyon_lines[index][idx] = '|' if (part == '.') && (@tachyon_lines[index - 1][idx] == '|')
      next unless part == '^' && @tachyon_lines[index - 1][idx] == '|'

      @split_count += 1

      @tachyon_lines[index][idx - 1] = '|'
      @tachyon_lines[index][idx + 1] = '|'
      @tachyon_lines[index + 1][idx - 1] = '|'
      @tachyon_lines[index + 1][idx + 1] = '|'

      @beam_locations[index + 1] << (idx - 1)
      @beam_locations[index + 1] << (idx + 1)
    end
  end
end

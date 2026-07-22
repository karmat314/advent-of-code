class BeamSplitterPartTwo
  attr_reader :tachyon_lines

  def initialize
    @tachyon_lines = File.readlines('./input.txt', chomp: true).map { |line| line.split('') }
    format_manifold
    init_beam
  end

  def traverse_tachyon_manifold
    @tachyon_lines.each_with_index do |_line, index|
      split_beam(index)
    end
  end

  def get_total_timelines
    @tachyon_lines.last.sum
  end

  private

  def format_manifold
    @tachyon_lines.each do |line|
      line.each_with_index do |part, idx|
        line[idx] = 0 if part == '.'
      end
    end
  end

  def init_beam
    @tachyon_lines[1][@tachyon_lines[0].index('S')] += 1
  end

  def split_beam(index)
    @tachyon_lines[index].each_with_index do |part, idx|
      @tachyon_lines[index][idx] = @tachyon_lines[index - 1][idx] if part == 0 && @tachyon_lines[index - 1][idx] != '^'
    end
    @tachyon_lines[index].each_with_index do |part, idx|
      @tachyon_lines[index][idx] = @tachyon_lines[index - 1][idx] if part == 0 && @tachyon_lines[index - 1][idx] != '^'
      next unless part == '^' && (@tachyon_lines[index - 1][idx].is_a? Numeric)

      puts "#{@tachyon_lines[index][idx - 1]}, #{@tachyon_lines[index - 1][idx]}, Line: #{index}, Index: #{idx}"
      @tachyon_lines[index][idx - 1] += @tachyon_lines[index - 1][idx]
      @tachyon_lines[index][idx + 1] += @tachyon_lines[index - 1][idx]
    end
  end
end

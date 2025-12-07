module Helpers
  class TachyonRow
    attr_reader :row

    def initialize(input:)
      @row = input
      @split_count = 0
      @new_beam_positions = []
    end

    def simulate(beam_positions)
      beam_positions.each do |index|
        # either the value at the index is a point or a splitter
        case row[index]
        when '.' # beam passes through
          row[index] = '|'
          @new_beam_positions |= [index]
        when '^' # beam splits
          @split_count += 1
          @new_beam_positions |= split_at_index(index)
        end
      end
      [@new_beam_positions, @split_count, timelines_created]
    end

    def display(total_timelines = 0)
      puts row.join(' ') + "    split_count = #{@split_count}, total_timelines = #{total_timelines}, timelines_created: #{timelines_created}"
    end

    private
    
    def split_at_index(index)
      if index > 0
        left_index = index - 1 
        row[left_index] = '|'
      end

      if index < last_row_index
        right_index = index + 1 
        row[right_index] = '|'
      end

      [left_index, right_index].compact
    end

    def last_row_index
      @last_row_index ||= row.size - 1
    end

    def timelines_created = @new_beam_positions.count
  end
end
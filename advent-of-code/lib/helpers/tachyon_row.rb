module Helpers
  class TachyonRow
    attr_reader :row, :split_count

    def initialize(input:)
      @row = input
      @split_count = 0
    end

    def simulate(beam_positions)
      new_beam_positions = []
      beam_positions.each do |index|
        # either the value at the index is a point or a splitter
        case row[index]
        when '.' # beam passes through
          row[index] = '|'
          new_beam_positions |= [index]
        when '^' # beam splits
          @split_count += 1
          new_beam_positions |= split_at_index(index)
        else
          # raise "wtf #{row[index]}"
        end
      end
      [new_beam_positions, @split_count]
    end

    def display
      puts row.join(' ')
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

  end
end
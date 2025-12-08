# frozen_string_literal: true

module Helpers
  class TachyonRow
    attr_reader :row

    def initialize(input:)
      @row = input
      @split_count = 0
      @new_beam_positions = Hash.new(0)
    end

    def simulate(beam_positions)
      beam_positions.each do |index, timeline_amount|
        # either the value at the index is a point or a splitter
        case row[index]
        when "." # beam passes through
          row[index] = "|"
          @new_beam_positions[index] += timeline_amount
        when "^" # beam splits
          @split_count += 1
          split_at_index(index, timeline_amount)
        else # straight beam into an split one
          @new_beam_positions[index] += timeline_amount
        end
      end
      [@new_beam_positions, @split_count]
    end

    def display
      puts row.join(" ") + "    split_count = #{@split_count}, total_timelines = #{@new_beam_positions.values.sum}"
    end

    private

    def split_at_index(index, timeline_amount)
      if index.positive?
        left_index = index - 1
        @new_beam_positions[left_index] += timeline_amount
        row[left_index] = "|"
      end

      return unless index < last_row_index

      right_index = index + 1
      @new_beam_positions[right_index] += timeline_amount
      row[right_index] = "|"
    end

    def last_row_index
      @last_row_index ||= row.size - 1
    end

    def timelines_created = @new_beam_positions.count
  end
end

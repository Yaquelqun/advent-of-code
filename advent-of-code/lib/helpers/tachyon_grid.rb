# frozen_string_literal: true

module Helpers
  class TachyonGrid
    attr_reader :rows, :total_split_count, :total_timelines, :input_grid

    def initialize(input_grid:)
      @input_grid = input_grid
      @total_split_count = 0
    end

    def simulate
      puts "start_simulation..."
      beam_positions = Hash.new(0).merge({ first_input_index => 1 })
      rows.first.display
      rows[1..].each do |row|
        beam_positions, split_count = row.simulate(beam_positions)
        @total_split_count += split_count
        @total_timelines = beam_positions.values.sum
        sleep(0.05)
        row.display
      end
      self
    end

    private

    def rows
      @rows ||= input_grid.map do |row|
        Helpers::TachyonRow.new(input: row)
      end
    end

    def simulate_row(index = 0)
      return if (index = rows.count - 1)

      row[index].simulate(index, rows)
      simulate_row(rows[index + 1], index + 1)
    end

    # first input
    def first_input_index = input_grid[0].index("S")
  end
end

# frozen_string_literal: true

module Helpers
  class TachyonGrid
    attr_reader :rows, :total_split_count, :total_timelines, :input_grid

    def initialize(input_grid:)
      @input_grid = input_grid
      @total_split_count = 0
      @total_timelines = 0
    end

    def simulate
      display
      puts "start_simulation..."
      beam_positions = [first_input_index]
      rows.first.display
      rows[1..].each do |row|
        beam_positions, split_count, timelines_created = row.simulate(beam_positions)
        @total_split_count += split_count
        @total_timelines += timelines_created if split_count > 0
        sleep(0.05)
        row.display(@total_timelines)
      end
      self
    end

    private

    def display
      rows.each(&:display)
    end

    def rows
      @rows ||= begin
        input_grid.map do |row|
          Helpers::TachyonRow.new(input: row)
        end
      end
    end

    def simulate_row(index = 0)
      return if index = rows.count-1
      row[index].simulate(index, rows)
      simulate_row(rows[index+1], index+1)
    end

    def first_input_index = input_grid[0].index('S') # first input
  end
end

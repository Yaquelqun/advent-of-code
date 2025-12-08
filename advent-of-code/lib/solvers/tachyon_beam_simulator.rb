# frozen_string_literal: true

module Solvers
  # Problem:
  # One line goes down from the S char on line 1
  # Once the line meets a ^, it splits it on both sides and it keeps
  # going
  class TachyonBeamSimulator
    attr_reader :grid

    def initialize(input: "day7")
      # get each line and split them into single chars
      @grid = Helpers::InputParser.new(input: input)
                                  .parse_data
                                  .map { _1.split("") }
    end

    def solve
      puts "parts1: #{solve_part1}" # 1560 is correct
      puts "parts2: #{solve_part2}" # 6195 is too low
    end

    def solve_part1
      simulation.total_split_count
    end

    def solve_part2
      simulation.total_timelines
    end

    private

    def simulation
      @simulation ||= Helpers::TachyonGrid.new(input_grid: grid)
                                          .simulate
    end
  end
end

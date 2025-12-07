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
      puts "parts1: #{solve_part1}" # is correct
      puts "parts2: #{solve_part2}" # is correct
    end

    def solve_part1
      Helpers::TachyonGrid.new(input_grid: grid)
                          .simulate
                          .split_count
    end

    def solve_part2(result = 0); end
  end
end

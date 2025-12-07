# frozen_string_literal: true

module Solvers
  # Problem:
  class TachyonBeamSimulator
    attr_reader :placeholder

    def initialize(input: "day7")
      # get each line and split them into single chars
      @placeholder = Helpers::InputParser.new(input: input)
                                         .parse_data
    end

    def solve
      puts "parts1: #{solve_part1}" # is correct
      puts "parts2: #{solve_part2}" # is correct
    end

    def solve_part1(result = 0); end

    def solve_part2(result = 0); end
  end
end

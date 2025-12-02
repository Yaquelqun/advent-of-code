# frozen_string_literal: true

# Problem:
# Given several ranges
# Iterate over all numbers in the range
# save numbers that are comprised of patterns
module Solvers
  class FalseIdsFinder
    attr_reader :ranges

    def initialize(input: "day2")
      @ranges = Helpers::InputParser.new(input: input)
                                   .parse_data
    end

    def solve
      puts "parts1: #{solve_part1}"
      puts "parts2: #{solve_part2}"
    end

    def solve_part1

    end

    def solve_part2
      'done2'
    end
  end
end

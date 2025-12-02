# frozen_string_literal: true

# Problem:
# Given several ranges
# Iterate over all numbers in the range
# save numbers that are comprised of patterns
module Solvers
  class FalseIdsFinder
    attr_reader :ranges

    def initialize(input: "day2")
      # Here the data is one line of "number-number" separated by ','
      @ranges = Helpers::InputParser.new(input: input)
                                    .parse_data.first # Get the line
                                    .split(",") # separate each range as strings
                                    .map { _1.split("-") } # for each string, separate both numbers
                                    .map { (_1.to_i.._2.to_i) } # rebuild the ranges with proper integers
    end

    def solve
      puts "parts1: #{solve_part1}"
      puts "parts2: #{solve_part2}"
    end

    def solve_part1
      false_ids = []
      ranges.each_with_index do |range, index|
        puts "Checking range #{range.inspect}, #{index + 1}/#{ranges.length}"
        patterned_numbers = Helpers::RangePatternFinder.new(range).patterned_numbers
        false_ids += patterned_numbers
      end
      false_ids.sum
    end

    def solve_part2
      "done2"
    end
  end
end

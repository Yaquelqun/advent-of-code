require_relative "../helpers/input_parser"

module AdventOfCode2022
  module Solvers
    class SectionCleaner
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day4_input")
                                    .parse_data
                                    .map { _1.split(",")}
      end

      def solve
        puts "number of covered space: #{solve_part1}" # Solution: 
      end

      private

      attr_reader :data

      def solve_part1
        @data.map { turn_to_ranges(_1) }
             .reduce(0) do |acc, ranges|
               range1, range2 = ranges
               acc += 1 if range1.cover?(range2) || range2.cover?(range1)
               acc
             end
      end

      def turn_to_ranges(inputs)
        inputs.map { _1.split("-").map(&:to_i) }
              .map { (_1[0].._1[1]) }
      end
    end
  end
end

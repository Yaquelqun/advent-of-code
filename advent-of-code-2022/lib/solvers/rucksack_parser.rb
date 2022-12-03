require_relative "../helpers/input_parser"

module AdventOfCode2022
  module Solvers
    class RucksackParser
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day3_input")
                                    .parse_data
      end

      def solve
        puts "common items priority sum: #{solve_part1}"
      end

      private

      attr_reader :data

      def solve_part1
        @data.map { split_rucksack(_1) }
             .map { find_common_element(_1) }
             .map { convert_to_priority(_1) }
             .sum
      end
    end
  end
end

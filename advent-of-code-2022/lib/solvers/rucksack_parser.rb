require_relative "../helpers/input_parser"

module AdventOfCode2022
  module Solvers
    class RucksackParser
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day3_input")
                                    .parse_data
                                    .map{ _1.split('') }
      end

      def solve
        puts "individual common items priority sum: #{solve_part1}" # Solution 8515
        puts "team common items priority sum: #{solve_part2}" # Solution 2434
      end

      private

      attr_reader :data

      def solve_part1
        @data.map { split_rucksack(_1) }
             .map { find_common_element(_1) }
             .map { convert_to_priority(_1) }
             .sum
      end

      def solve_part2
        group_rucksacks_by_teams
          .map { find_common_element(_1) }
          .map { convert_to_priority(_1) }
          .sum
      end

      def split_rucksack(rucksack_content)
        rucksack_content.each_slice(rucksack_content.length / 2).to_a
      end

      def find_common_element(compartments)
        compartments.reduce(compartments[0]) { _1 & _2 }[0]
      end

      PRIORITIES = ("a".."z").to_a + ("A".."Z").to_a
      def convert_to_priority(element)
        PRIORITIES.index(element) + 1
      end

      def group_rucksacks_by_teams
        @data.each_slice(3).to_a
      end
    end
  end
end

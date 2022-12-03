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
        puts "common items priority sum: #{solve_part1}"
      end

      private

      attr_reader :data

      def solve_part1
        @data.map { split_rucksack(_1) }
             .map { find_common_element(*_1) }
             .map { convert_to_priority(_1) }
             .sum
      end

      def split_rucksack(rucksack_content)
        rucksack_content.each_slice(rucksack_content.length / 2).to_a
      end

      def find_common_element(compartment1, compartment2)
        (compartment1 & compartment2)[0]
      end

      PRIORITIES = ("a".."z").to_a + ("A".."Z").to_a
      def convert_to_priority(element)
        PRIORITIES.index(element) + 1
      end
    end
  end
end

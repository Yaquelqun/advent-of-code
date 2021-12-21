require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    class SonarSweep

      def initialize
        @data = Helpers::InputParser.new(endpoint: 'day1_input').parse_data.map(&:to_i)
      end

      def solve
        puts "number of increases: #{part1_solution}"
      end

      private
      attr_reader :data

      def part1_solution
        increase_number = 0
        data[1..].each_with_index { |number, index| increase_number += 1 if data[index] < number }
        return increase_number
      end
    end
  end
end

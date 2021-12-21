# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # Computes height changes given a list of depths
    class SonarSweep
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day1_input").parse_data.map(&:to_i)
      end

      def solve
        puts "number of increases: #{part1_solution}"
        puts "number of summed increases: #{part2_solution}"
      end

      private

      attr_reader :data

      def part1_solution
        increase_number = 0
        data[1..].each_with_index { |number, index| increase_number += 1 if data[index] < number }
        increase_number
      end

      def part2_solution
        summed_data = data[2..].map.with_index { |number, index| number + data[index] + data[index + 1] }
        increase_number = 0
        summed_data[1..].each_with_index { |number, index| increase_number += 1 if summed_data[index] < number }
        increase_number
      end
    end
  end
end

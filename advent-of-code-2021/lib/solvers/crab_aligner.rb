# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # aligns crab submarines
    class CrabAligner
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day7_input").parse_data
      end

      def solve
        puts "minimal fuel usage: #{part1_solution}" # Solution: 344605
        # puts "realistic minimal fuel usage: #{part2_solution}" # Solution: 
      end

      private

      attr_reader :data

      def part1_solution
        crab_positions = parse_input
        median = crab_positions.sort[crab_positions.length/2]
        crab_positions.map { (median - _1).abs }.sum
      end

      def parse_input
        data.first.split(",").map(&:to_i)
      end
    end
  end
end

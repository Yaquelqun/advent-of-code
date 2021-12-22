# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # simulate bingo rounds
    class VentsMapper
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day4_input").parse_data
      end

      def solve
        puts "strait vents intersection numbers: #{part1_solution}" # Solution:
        # puts "last card score: #{part2_solution}" # Solution: 19012
      end

      private

      attr_reader :data

      def part1_solution; end

      def part2_solution; end
    end
  end
end

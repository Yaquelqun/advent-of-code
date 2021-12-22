# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # simulate bingo rounds
    class LanternFishWatcher
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day5_input").parse_data
      end

      def solve
        puts "lanternfish amount: #{part1_solution}" # Solution:
        # puts "all vents intersection numbers: #{part2_solution}" # Solution: 22083
      end

      private

      attr_reader :data

      def part1_solution; end

      def part2_solution; end
    end
  end
end

# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # aligns crab submarines
    class CrabAligner
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day6_input").parse_data
      end

      def solve
        puts "minimal fuel usage: #{part1_solution}" # Solution: 362740
        # puts "lanternfish amount after 256 days: #{populations.sum}" # Solution: 1644874076764
      end

      private

      attr_reader :data

      def part1_solution

      end

      def parse_input
        data.first.split(",").map(&:to_i)
      end
    end
  end
end

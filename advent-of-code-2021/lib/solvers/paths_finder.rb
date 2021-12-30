# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # Navigates cave map
    class PathsFinder
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day12_input").parse_data
      end

      def solve
        puts "paths amount: #{part1_solution}" # Solution: 
        puts ": #{part2_solution}" # Solution:
      end

      private

      attr_reader :data

      def part1_solution
      end

      def part2_solution
      end

      def parsed_input
        @parsed_input ||= data.map { _1.split("-") }
      end
    end
  end
end

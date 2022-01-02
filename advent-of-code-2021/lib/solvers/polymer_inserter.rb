# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # Extends a polymer according to rules
    class PageFolder
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day14_input").parse_data
      end

      def solve
        puts "most - least common element after 10 steps: #{part1_solution}" # Solution:
        puts ":#{part2_solution}" # Solution:
      end

      private

      attr_reader :data

      def part1_solution
      end

      def part2_solution
      end

      def polymer
        @polymer ||= data.first.split('')
      end

      def rules
        @rules ||= data[2..].split(' -> ').to_h
      end
    end
  end
end

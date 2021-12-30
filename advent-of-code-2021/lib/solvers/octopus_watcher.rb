# frozen_string_literal: true
require_relative "../helpers/input_parser"
require 'matrix'

module AdventOfCode2021
  module Solvers
    # simulates octopus flashing
    class OctopusWatcher
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day11_input").parse_data
      end

      def solve
        puts "flashes amount: #{part1_solution}" # Solution: 1700
        @parsed_input = nil
        puts "first synchronized flash: #{part2_solution}" # Solution:
      end

      private

      attr_reader :data

      def part1_solution
        (1..100).reduce(0) { |acc, _| acc + flashes_during_next_round }
      end

      def part2_solution
      end

      def flashes_during_next_round
        parsed_input.map!(&:next)
        parsed_input.each_with_index do |value, row, column|
          trigger_flash([row, column]) if value > 9
        end

        parsed_input.count(&:zero?)
      end

      def trigger_flash(coordinates)
        parsed_input[*coordinates] = 0
        build_target(*coordinates).each do |target_coordinates|
          next if parsed_input[*target_coordinates].zero?

          parsed_input[*target_coordinates] += 1
          trigger_flash(target_coordinates) if parsed_input[*target_coordinates] > 9
        end
      end

      def build_target(row, column)
        max_row_value = data.length - 1
        max_column_value = data.first.length - 1

        [
          [row - 1, column - 1],
          [row - 1, column],
          [row - 1, column + 1],
          [row, column - 1],
          [row, column + 1],
          [row + 1, column - 1],
          [row + 1, column],
          [row + 1, column + 1]
        ].select { _1.between?(0, max_row_value) && _2.between?(0, max_column_value) }
      end

      def parsed_input
        @parsed_input ||= Matrix[*data.map { _1.split("").map(&:to_i) }]
      end
    end
  end
end

# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # finds low points in height map
    class HeightParser
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day9_input").parse_data
      end

      def solve
        puts "map risk level: #{part1_solution}" # Solution: < 1655
        #puts "all vents intersection numbers: #{part2_solution}" # Solution:
      end

      private

      attr_reader :data

      def part1_solution
        risk_level = 0
        map[1..-2].each.with_index(1) do |height_row, row|
          height_row[1..-2].each.with_index(1) do |height, column|
            if check_for_local_minimum(row, column, height)
              risk_level += (1 + height) 
            end
          end
        end
        risk_level
      end

      def part2_solution
      end

      def check_for_local_minimum(row, column, height)
        build_target(row, column).map { map.dig(*_1) }.all?{ height < _1}
      end

      def build_target(row, column)
        [
          [row, column - 1],
          [row, column + 1],
          [row - 1, column],
          [row + 1, column]
        ]
      end

      def map
        @map ||= begin
          [Array.new(data.first.length + 2 ) { Float::INFINITY }] + 
          data.map do |data_line|
            [Float::INFINITY] + data_line.split('').map(&:to_i) + [Float::INFINITY]
          end + 
          [Array.new(data.first.length + 2) { Float::INFINITY }]
        end
      end

      def display_map
        map.each { puts _1.join }
        nil
      end
    end
  end
end

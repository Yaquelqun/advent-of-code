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
        puts "map risk level: #{part1_solution}" # Solution: 575
        puts "largest basins product: #{part2_solution}" # Solution: 1019700
      end

      private

      attr_reader :data

      def part1_solution
        risk_level = 0
        map[1..-2].each.with_index(1) do |height_row, row|
          height_row[1..-2].each.with_index(1) do |height, column|
            risk_level += (1 + height) if check_for_local_minimum(row, column, height)
          end
        end
        risk_level
      end

      def check_for_local_minimum(row, column, height)
        build_target(row, column).map { map.dig(*_1) }.all?{ height < _1}
      end

      def part2_solution
        low_points = []
        map[1..-2].each.with_index(1) do |height_row, row|
          height_row[1..-2].each.with_index(1) do |height, column|
            low_points << [[row, column]] if check_for_local_minimum(row, column, height)
          end
        end
        basin_sizes = []
        low_points.each do |basin|
          basin_sizes << expand_basin(basin).length
        end
        basin_sizes.sort.last(3).reduce(&:*)
      end

      def expand_basin(basin)
        expanded_basin = basin.dup
        until basin.empty?
          row, column = basin.shift
          value = map.dig(row, column)
          upflow_points = build_target(row, column).map do |trow, tcolumn|
            map_value = map.dig(trow, tcolumn)
            [trow, tcolumn] if ![9, Float::INFINITY].include?(map_value) && map_value > value
          end.compact
          basin |= upflow_points
          expanded_basin |= upflow_points
        end
        expanded_basin
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
        @map ||= [Array.new(data.first.length + 2) { Float::INFINITY }] +
                 data.map do |data_line|
                   [Float::INFINITY] + data_line.split("").map(&:to_i) + [Float::INFINITY]
                 end +
                 [Array.new(data.first.length + 2) { Float::INFINITY }]
      end

      def display_map
        map.each { puts _1.join }
        nil
      end
    end
  end
end

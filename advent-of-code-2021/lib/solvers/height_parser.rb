# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # finds low points in height map
    class HeightParser
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day9_input").parse_data
        @row_length = @data.first.length
      end

      def solve
        puts "map risk level: #{part1_solution}" # Solution: 575
        puts "largest basins product: #{part2_solution}" # Solution: 1019700
      end

      private

      attr_reader :data

      def part1_solution
        low_points.reduce(0) do |risk_level, coordinates|
          risk_level + map.dig(*coordinates) + 1
        end
      end

      def part2_solution
        basin_sizes = []
        low_points.each do |basin|
          basin_sizes << expand_basin([basin]).length
        end
        basin_sizes.sort.last(3).reduce(&:*)
      end

      def low_points
        @low_points ||= begin
          result = []
          map[1..-2].each.with_index(1) do |height_row, row|
            height_row[1..-2].each.with_index(1) do |height, column|
              result << [row, column] if check_for_local_minimum(row, column, height)
            end
          end
          result
        end
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

      def expand_basin(basin, expanded_basin = basin.dup)
        return expanded_basin if basin.empty?

        row, column = basin.shift
        value = map.dig(row, column)
        upflow_points = build_target(row, column).select do |trow, tcolumn|
          map_value = map.dig(trow, tcolumn)
          ![9, Float::INFINITY].include?(map_value) && map_value > value
        end
        basin |= upflow_points
        expanded_basin |= upflow_points
        expand_basin(basin, expanded_basin)
      end

      def map
        @map ||= [Array.new(@row_length + 2) { Float::INFINITY }] +
                 data.map { [Float::INFINITY] + _1.split("").map(&:to_i) + [Float::INFINITY] } +
                 [Array.new(@row_length + 2) { Float::INFINITY }]
      end
    end
  end
end

# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # simulate bingo rounds
    class VentsMapper
      def initialize
        @data = Helpers::InputParser.new(endpoint: 'day5_input').parse_data
      end

      def solve
        puts "strait vents intersection numbers: #{part1_solution}" # Solution: 5169
        puts "all vents intersection numbers: #{part2_solution}" # Solution: 22083
      end

      private

      attr_reader :data

      def part1_solution
        map = [] # Could be a hash, will depend on part2
        coordinates = parsed_input
        coordinates.each do |coordinate|
          next unless coordinate[0][0] == coordinate[1][0] || coordinate[0][1] == coordinate[1][1]

          row_range = [coordinate[0][0], coordinate[1][0]].sort
          column_range = [coordinate[0][1], coordinate[1][1]].sort
          (row_range.first..row_range.last).each do |row|
            map[row] ||= []
            (column_range.first..column_range.last).each do |column|
              if map[row][column].nil?
                map[row][column] = 1
              else
                map[row][column] += 1
              end
            end
          end
        end

        map.flatten.compact.count { _1 > 1 }
      end

      def part2_solution
        map = Hash.new { 0 }
        coordinates = parsed_input
        coordinates.each do |coordinate|
          current_row, target_row = [coordinate[0][0], coordinate[1][0]]
          current_column, target_column = [coordinate[0][1], coordinate[1][1]]
          # next unless current_row == target_row || current_column == target_column

          row_direction = target_row <=> current_row
          column_direction = target_column <=> current_column

          until current_row == target_row && current_column == target_column
            map[[current_row, current_column]] += 1
            current_row += row_direction
            current_column += column_direction
          end

          map[[current_row, current_column]] += 1
        end

        map.values.count { _1 > 1 }
      end

      def parsed_input
        @parsed_input ||= data.map do |data_line|
          data_line                 # "562,433 -> 241,754"
          .split('->')              # ["562,433", "241,754"]
          .map { _1.split(',') }     # [["562", "433"], ["241", "754"]]
          .map { _1.map(&:to_i) }    # [[562, 433], [241, 754]]
        end
      end
    end
  end
end

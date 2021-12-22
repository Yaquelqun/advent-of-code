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
        puts "strait vents intersection numbers: #{part1_solution}" # Solution:
        # puts "last card score: #{part2_solution}" # Solution: 19012
      end

      private

      attr_reader :data

      def part1_solution
        map = [] # Could be a hash, will depend on part2
        coordinates = parse_input
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

      def part2_solution; end

      def parse_input
        data.map do |data_line|
          data_line                 # "562,433 -> 241,754"
          .split('->')              # ["562,433", "241,754"]
          .map { _1.split(',') }     # [["562", "433"], ["241", "754"]]
          .map { _1.map(&:to_i) }    # [[562, 433], [241, 754]]
        end
      end
    end
  end
end

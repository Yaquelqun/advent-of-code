# frozen_string_literal: true

require_relative "../helpers/input_parser"
require_relative "../models/line"

module AdventOfCode2021
  module Solvers
    # simulate bingo rounds
    class VentsMapper
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day5_input").parse_data
        @map = Hash.new { 0 }
      end

      def solve
        puts "strait vents intersection numbers: #{part1_solution}" # Solution: 5169
        @map = Hash.new { 0 }
        puts "all vents intersection numbers: #{part2_solution}" # Solution: 22083
      end

      private

      attr_reader :data, :map

      def part1_solution
        coordinates = parsed_input.select do |coordinate|
          coordinate[0][0] == coordinate[1][0] || coordinate[0][1] == coordinate[1][1]
        end
        complete_map(coordinates)
        count_intersections
      end

      def part2_solution
        complete_map(parsed_input)
        count_intersections
      end

      def parsed_input
        @parsed_input ||= data.map do |data_line|
          data_line                    # "562,433 -> 241,754"
            .split("->")               # ["562,433", "241,754"]
            .map { _1.split(",") }     # [["562", "433"], ["241", "754"]]
            .map { _1.map(&:to_i) }    # [[562, 433], [241, 754]]
        end
      end

      def complete_map(coordinates)
        coordinates.each do |coordinate|
          line = Models::Line.new(coordinate)
          until line.processed?
            map[line.pointer] += 1
            line.move_pointer
          end

          map[line.pointer] += 1
        end
      end

      def count_intersections
        map.values.count { _1 > 1 }
      end
    end
  end
end

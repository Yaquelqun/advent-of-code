# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # Computes height changes given a list of depths
    class DirectionInterpreter
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day2_input").parse_data
      end

      def solve
        puts "depth * horizontal position = #{part1_solution}" # Solution: 2120749
        puts "depth * horizontal position = #{part2_solution}" # Solution: 2138382217
      end

      private
      attr_reader :data

      INSTRUCTIONS = {
        'forward' => %I[horizontal +],
        'down' => %I[depth +],
        'up' => %I[depth -]
      }.freeze
      def part1_solution
        current_position = { horizontal: 0, depth: 0 }
        directions = data.map do |direction|
          instruction = direction.split
          INSTRUCTIONS[instruction.first] + [instruction.last.to_i]
        end
        directions.each { |direction, change, value| current_position[direction] = current_position[direction].send(change, value)}
        current_position.values.reduce(&:*)
      end

      def part2_solution
        current_position = { horizontal: 0, depth: 0, aim: 0 }
        data.each do |instruction|
          instruction = instruction.split
          case instruction.first
          when 'down'
            current_position[:aim] += instruction.last.to_i
          when 'up'
            current_position[:aim] -= instruction.last.to_i
          when 'forward'
            current_position[:horizontal] += instruction.last.to_i
            current_position[:depth] += (instruction.last.to_i * current_position[:aim])
          end
        end
        current_position[:horizontal] * current_position[:depth]
      end
    end
  end
end

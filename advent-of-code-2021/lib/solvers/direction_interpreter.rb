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
        # puts "number of summed increases: #{part2_solution}"
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

      end

    end
  end
end

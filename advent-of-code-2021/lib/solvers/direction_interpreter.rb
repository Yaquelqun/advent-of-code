# frozen_string_literal: true

require_relative "../helpers/input_parser"
require_relative "../models/submarine_position"

module AdventOfCode2021
  module Solvers
    # predict submarine final position
    class DirectionInterpreter
      INSTRUCTIONS = {
        "forward" => :move_forward,
        "down" => :increase_depth,
        "up" => :decrease_depth
      }.freeze

      UPDATED_INSTRUCTIONS = {
        "forward" => :move_forward,
        "down" => :increase_aim,
        "up" => :decrease_aim
      }.freeze

      def initialize
        @data = Helpers::InputParser.new(endpoint: "day2_input").parse_data
        @position = Models::SubmarinePosition.new
      end

      def solve
        puts "depth * horizontal position = #{read_instructions(instructions_set: INSTRUCTIONS)}" # Solution: 2120749
        @position.reset
        puts "depth * horizontal position = #{read_instructions(instructions_set: UPDATED_INSTRUCTIONS)}" # Solution: 2138382217
      end

      private

      attr_reader :data, :position

      def read_instructions(instructions_set:)
        instructions = parse_data(instructions_set: instructions_set)
        instructions.each { |action, value| position.send(action, value) }
        position.multiply_coordinates
      end

      def parse_data(instructions_set:)
        data.map do |data_line|
          order, value = data_line.split
          [instructions_set[order], value.to_i]
        end
      end
    end
  end
end

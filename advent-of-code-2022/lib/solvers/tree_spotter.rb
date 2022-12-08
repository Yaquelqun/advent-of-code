# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2022
  module Solvers
    class TreeSpotter
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day8_input")
                                    .parse_data
                                    .map { _1.split("").map(&:to_i) }
      end

      def solve
        puts "Amount of visible trees: #{solve_part1}" # Solution: 
      end

      private

      attr_reader :data

      DIRECTIONS = %w[up down left right].freeze

      def solve_part1
        x, y = [0, 0]
        count = 1
        while y <= max_y
          x, y = increment_counter(x: x, y: y)
        end

        [x, y]
      end

      def increment_counter(x:, y:)
        x += 1
        if x > max_x
          x = 0
          y += 1
        end
        [x, y]
      end

      def max_x
        @max_x ||= @data[0].length - 1
      end

      def max_y
        @max_y ||= @data.length - 1
      end
    end
  end
end

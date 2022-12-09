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
        visible_count, max_scenic_score = parse_forest
        puts "Amount of visible trees: #{visible_count}" # Solution: 1543
        puts "maximum scenic score: #{max_scenic_score}" # Solution: 595080
      end

      private

      attr_reader :data

      DIRECTIONS = %w[up down left right].freeze

      def parse_forest
        x = y = 0
        visibility_count = max_scenic_score = 0
        while y <= max_y
          visibility_count += 1 if DIRECTIONS.any? { send("visible_from_#{_1}?", x, y) }
          scenic_score = DIRECTIONS.map {send("visibility_looking_#{_1}", x, y)}.inject(&:*)
          max_scenic_score = scenic_score if scenic_score > max_scenic_score
          x, y = increment_counter(x: x, y: y)
        end

        [visibility_count, max_scenic_score]
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

      def value_at(x, y)
        @data[y][x]
      end

      def visibility_looking_up(x, y)
        view = (0..(y - 1)).map { value_at(x, _1) }.reverse
        visibility = view.index { _1 >= value_at(x, y) } || y - 1
        visibility + 1
      end

      def visible_from_up?(x, y)
        return true if y.zero?

        (0..(y - 1)).all? { value_at(x, _1) < value_at(x, y)}
      end

      def visibility_looking_down(x, y)
        view = ((y + 1)..max_y).map { value_at(x, _1) }
        visibility = view.index { _1 >= value_at(x, y) } || max_y - y - 1
        visibility + 1
      end

      def visible_from_down?(x, y)
        return true if y == max_y

        ((y + 1)..max_y).all? { value_at(x, _1) < value_at(x, y) }
      end

      def visibility_looking_left(x, y)
        view = (0..(x - 1)).map { value_at(_1, y) }.reverse
        visibility = view.index { _1 >= value_at(x, y) } || x - 1
        visibility + 1
      end

      def visible_from_left?(x, y)
        return true if x.zero?

        (0..(x - 1)).all? { value_at(_1, y) < value_at(x, y)}
      end

      def visibility_looking_right(x, y)
        view = ((x + 1)..max_x).map { value_at(_1, y) }
        visibility = view.index { _1 >= value_at(x, y) } || max_x - x - 1
        visibility + 1
      end

      def visible_from_right?(x, y)
        return true if x == max_x

        ((x + 1)..max_x).all? { value_at(_1, y) < value_at(x, y) }
      end
    end
  end
end

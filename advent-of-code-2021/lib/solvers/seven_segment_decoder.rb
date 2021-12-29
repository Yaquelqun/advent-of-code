# frozen_string_literal: true

require_relative "../helpers/input_parser"
require_relative "../models/seven_segment"

module AdventOfCode2021
  module Solvers
    # decodes messed up 7 segments
    class SevenSegmentDecoder
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day8_input").parse_data
      end

      def solve
        puts "simple number count: #{part1_solution}" # Solution: 445
        puts "code sum: #{part2_solution}" # Solution:
      end

      private

      attr_reader :data

      def part1_solution
        seven_segments = parse_input.map { |combinations, output| Models::SevenSegment.new(combinations, output) }
        seven_segments.map(&:decode_output)
        seven_segments.map(&:code).flatten.count { [1, 4, 7, 8].include? _1 }
      end

      def part2_solution
        seven_segments = parse_input.map { |combinations, output| Models::SevenSegment.new(combinations, output) }
        seven_segments.map(&:decode_output)
        seven_segments.map(&:code).map(&:join).map(&:to_i).sum
      end

      def parse_input
        data.map { _1.split(' | ').map(&:split) }
      end
    end
  end
end

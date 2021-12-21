# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # Computes height changes given a list of depths
    class SonarSweep
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day1_input").parse_data.map(&:to_i)
      end

      def solve
        puts "number of increases: #{part1_solution}"
        puts "number of summed increases: #{part2_solution}"
      end

      private

      attr_reader :data

      def part1_solution
        find_increases(data)
      end

      def part2_solution
        summed_data = data.each_cons(3).map(&:sum)
        find_increases(summed_data)
      end

      def find_increases(depth_list)
        depth_list.each_cons(2).count { |s| s.last > s.first}
      end
    end
  end
end

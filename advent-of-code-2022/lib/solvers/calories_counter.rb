# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2022
  module Solvers
    # finds low points in height map
    class CaloriesCounter
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day1_input").parse_data.map(&:to_i)
        @calory_max = 0
      end

      def solve
        puts "highest calory count: #{part1_solution}" # Solution: 68787
        puts " #{}" # Solution: 
      end

      private

      attr_reader :data

      def part1_solution
        current_max = 0
        data.each do |count|
          if count != 0
            current_max += count
            next
          end

          compare_calory_max(current_max)
          current_max = 0
        end
        @calory_max
      end

      def compare_calory_max(potential_max)
        @calory_max = potential_max if potential_max > @calory_max
      end
    end
  end
end

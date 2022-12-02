# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2022
  module Solvers
    # finds low points in height map
    class CaloriesCounter
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day1_input").parse_data.map(&:to_i)
      end

      def solve
        puts "highest calory count: #{sorted_calory_count.last}" # Solution: 68787
        puts " three highest calory count: #{sorted_calory_count[-3..].sum}" # Solution: 198041
      end

      private

      attr_reader :data

      def sorted_calory_count
        @sorted_calory_count ||= isolated_elf_foods.map(&:sum).sort
      end

      def isolated_elf_foods
        result = []
        data.reduce([]) do |current_elf_foods, count|
          current_elf_foods << count and next(current_elf_foods) if count != 0

          result << current_elf_foods
          next([])
        end
        result
      end
    end
  end
end

# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2022
  module Solvers
    # finds low points in height map
    class CaloriesCounter
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day1_input").parse_data
        @row_length = @data.first.length
      end

      def solve
        puts "highest calory count: #{20}" # Solution: 
        puts " #{}" # Solution: 
      end

      private

      attr_reader :data
    end
  end
end

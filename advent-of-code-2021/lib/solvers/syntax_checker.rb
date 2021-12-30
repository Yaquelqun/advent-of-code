module AdventOfCode2021
  module Sovers
    # Checks syntax of a line of code
    class SyntaxChecker
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day10_input").parse_data
      end


      def solve
        puts "total syntax error score: #{part1_solution}" # Solution: 
        puts ": #{part2_solution}" # Solution: 
      end

      private

      attr_reader :data

      def part1_solution
      end

      def part2_solution
      end

      def parsed_input
        @parsed_input ||= begin

        end
      end
    end
  end
end
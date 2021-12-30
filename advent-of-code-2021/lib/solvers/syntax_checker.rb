module AdventOfCode2021
  module Solvers
    # Checks syntax of a line of code
    class SyntaxChecker
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day10_input").parse_data
      end


      def solve
        puts "total syntax error score: #{part1_solution}" # Solution: 243939
        puts ": #{part2_solution}" # Solution: 
      end

      private

      attr_reader :data

      BRACKETS_DICTIONNARY = {
        '(' => ')',
        '{' => '}',
        '[' => ']',
        '<' => '>'
      }.freeze

      ILLEGAL_CHARACTER_SCORES = {
        ')' => 3,
        ']' => 57,
        '}' => 1197,
        '>' => 25_137
      }.freeze

      def part1_solution
        parsed_input.reduce(0) do |score, char_line|
          score + check_line(char_line)
        end
      end

      def part2_solution
      end

      def check_line(line)
        expected_closers = []
        line.each do |char|
          if BRACKETS_DICTIONNARY.keys.include?(char)
            expected_closers << BRACKETS_DICTIONNARY[char]
          elsif char != expected_closers.pop
            return ILLEGAL_CHARACTER_SCORES[char]
          end
        end
        0
      end

      def parsed_input
        @parsed_input ||= data.map { _1.split('') }
      end
    end
  end
end

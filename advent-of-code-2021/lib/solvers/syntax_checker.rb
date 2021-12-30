# frozen_string_literal: true

module AdventOfCode2021
  module Solvers
    # Checks syntax of a line of code
    class SyntaxChecker
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day10_input").parse_data
      end

      def solve
        puts "total syntax error score: #{part1_solution}" # Solution: 243939
        puts "median of the completion scores: #{part2_solution}" # Solution: 2421222841
      end

      private

      attr_reader :data

      BRACKETS_DICTIONNARY = {
        "(" => ")",
        "{" => "}",
        "[" => "]",
        "<" => ">"
      }.freeze

      ILLEGAL_CHARACTER_SCORES = {
        ")" => 3,
        "]" => 57,
        "}" => 1197,
        ">" => 25_137
      }.freeze

      COMPLETION_SCORES = {
        ")" => 1,
        "]" => 2,
        "}" => 3,
        ">" => 4
      }.freeze

      def part1_solution
        parsed_input.reduce(0) do |score, char_line|
          score + check_line(char_line, "corruption")
        end
      end

      def part2_solution
        completion_scores = parsed_input.map { check_line(_1, "completion") }.reject(&:zero?)

        completion_scores.sort[completion_scores.length / 2]
      end

      def check_line(line, scoring_method)
        expected_closers = []
        line.each do |char|
          if BRACKETS_DICTIONNARY.keys.include?(char)
            expected_closers << BRACKETS_DICTIONNARY[char]
          elsif char != expected_closers.pop
            return scoring_method == "corruption" ? ILLEGAL_CHARACTER_SCORES[char] : 0
          end
        end
        scoring_method == "completion" ? compute_completion_score(expected_closers.reverse) : 0
      end

      def compute_completion_score(completion_characters)
        completion_characters.reduce(0) { |acc, char| acc * 5 + COMPLETION_SCORES[char] }
      end

      def parsed_input
        @parsed_input ||= data.map { _1.split("") }
      end
    end
  end
end

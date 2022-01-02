# frozen_string_literal: true

require_relative "../helpers/input_parser"
require_relative "../models/dotted_page"

module AdventOfCode2021
  module Solvers
    # folds dotted page
    class PageFolder
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day13_input").parse_data
      end

      def solve
        puts "visible dots after first fold: #{part1_solution}" # Solution: 682
        puts "all folds result:\n #{part2_solution}" # Solution: FAGURZHZE
      end

      private

      attr_reader :data

      def part1_solution
        page = generate_page
        first_instruction = folding_instructions[0]
        page.send("fold_along_#{first_instruction[0]}", first_instruction[1])
        page.dot_count
      end

      def part2_solution
        page = generate_page
        folding_instructions.each { page.send("fold_along_#{_1[0]}", _1[1]) }
        page.display_result
      end

      def dot_coordinates
        @dot_coordinates ||= begin
          empty_line_index = data.index("")
          data[..(empty_line_index - 1)].map { _1.split(',').map(&:to_i) }
        end
      end

      def folding_instructions
        @folding_instructions ||= begin
          empty_line_index = data.index("")
          data[(empty_line_index + 1)..].map { |instruction| instruction[11..].split('=') }.map { [_1, _2.to_i]}
        end
      end

      def generate_page
        width = dot_coordinates.map(&:first).max
        height = dot_coordinates.map(&:last).max
        page = Models::DottedPage.new(height: height, width: width)
        page.add_dots(dot_coordinates)
        page
      end
    end
  end
end

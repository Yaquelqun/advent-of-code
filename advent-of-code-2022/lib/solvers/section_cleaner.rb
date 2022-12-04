require_relative "../helpers/input_parser"

module AdventOfCode2022
  module Solvers
    class SectionCleaner
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day4_input")
                                    .parse_data
                                    .map { _1.split(",")}
      end

      def solve
        puts "number of totally covered space: #{tally_covers(cover_option: "total")}" # Solution: 453
        puts "number of partially covered space: #{tally_covers(cover_option: "partial")}" # Solution: 
      end

      private

      attr_reader :data

      def tally_covers(cover_option:)
        @data.map { turn_to_ranges(_1) }
             .reduce(0) do |acc, ranges|
               range1, range2 = ranges
               acc += 1 if send("#{cover_option}_cover_between?", range1, range2)
               acc
             end
      end

      def turn_to_ranges(inputs)
        inputs.map { _1.split("-").map(&:to_i) }
              .map { (_1[0].._1[1]) }
      end

      def total_cover_between?(range1, range2)
        range1.cover?(range2) || range2.cover?(range1)
      end

      def partial_cover_between?(range1, range2)
        lower_starting_range, higher_starting_range = [range1, range2].sort_by(&:first)
        higher_starting_range.first <= lower_starting_range.last
      end
    end
  end
end

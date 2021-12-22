# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # simulate bingo rounds
    class LanternFishWatcher
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day6_input").parse_data
      end

      def solve
        puts "lanternfish amount: #{part1_solution}" # Solution:
        # puts "all vents intersection numbers: #{part2_solution}" # Solution: 22083
      end

      private

      attr_reader :data

      def part1_solution
        populations = [0] + parse_input.tally.sort_by(&:first).map(&:last) + [0, 0, 0]
        80.times do |index|
          next_generation = populations.first
          populations.map.with_index do |population, countdown|
            next if countdown.zero?

            populations[countdown - 1] = population
            populations[countdown] = 0
          end
          populations[6] += next_generation
          populations[8] += next_generation
        end
        populations.sum
      end

      def part2_solution; end

      def parse_input
        data.first.split(',').map(&:to_i)
      end
    end
  end
end

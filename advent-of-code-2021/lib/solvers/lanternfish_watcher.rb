# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # simulate bingo rounds
    class LanternFishWatcher
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day6_input").parse_data

        # @populations is a 9 element array.
        # For each position, the value is the amount of fish that are `position day away from reproduction`
        @populations = [0] + parse_input.tally.sort_by(&:first).map(&:last) + [0, 0, 0]
      end

      def solve
        simulate_populations(days: 80)
        puts "lanternfish amount after 80 days: #{populations.sum}" # Solution: 362740
        simulate_populations(days: 176)
        puts "lanternfish amount after 256 days: #{populations.sum}" # Solution: 1644874076764
      end

      private

      attr_reader :data, :populations

      def simulate_populations(days:)
        days.times do
          next_generation = populations.first
          simulate_day
          populations[6] += next_generation
          populations[8] += next_generation
        end
      end

      def simulate_day
        populations.map.with_index do |population, countdown|
          next if countdown.zero?

          populations[countdown - 1] = population
          populations[countdown] = 0
        end
      end

      def parse_input
        data.first.split(",").map(&:to_i)
      end
    end
  end
end

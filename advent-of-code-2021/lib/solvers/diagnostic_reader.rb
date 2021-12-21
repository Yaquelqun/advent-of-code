# frozen_string_literal: true

require_relative "../helpers/input_parser"
require_relative "../models/tally"

module AdventOfCode2021
  module Solvers
    # decodes submarine's report
    class DiagnosticReader
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day3_input").parse_data.sort
        @number_length = @data.first.length
      end

      def solve
        puts "gamma * epsilon rates = #{part1_solution}" # Solution: 2583164
        puts "oxygen generator * CO2 scrubber rates = #{part2_solution}" # Solution: 2784375
      end

      private

      attr_reader :data, :number_length

      def part1_solution
        gamma = []
        epsilon = []
        number_length.times do |current_digit|
          tally = Models::Tally.new(data.map { _1[current_digit] })
          gamma << tally.most_frequent_value
          epsilon << tally.least_frequent_value
        end

        gamma.join.to_i(2) * epsilon.join.to_i(2)
      end

      def part2_solution
        oxygen_generator = pinpoint_value(rule: :most_frequent_value).to_i(2)
        co2_scrubber = pinpoint_value(rule: :least_frequent_value).to_i(2)
        oxygen_generator * co2_scrubber
      end

      def pinpoint_value(rule:)
        current_list = data
        number_length.times do |current_digit|
          return current_list.first if current_list.count == 1

          digits = current_list.map { _1[current_digit] }
          tally = Models::Tally.new(digits)

          current_list = apply_rule(current_list, tally, rule)
        end
      end

      def apply_rule(list, tally, rule)
        if tally.send(rule) == "1"
          list.last(tally.tally["1"] || list.count - 1)
        else
          list.first(tally.tally["0"] || list.count - 1)
        end
      end
    end
  end
end

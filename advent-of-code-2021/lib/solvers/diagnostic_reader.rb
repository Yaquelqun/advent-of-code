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
        # puts "oxygen generator * CO2 scrubber rates = #{part2_solution}" # Solution: 2784375
      end

      private

      attr_reader :data, :number_length

      def part1_solution
        gamma = [ ]
        epsilon = [ ]
        number_length.times do |index| # for each bit position in the binary number
          tally = Models::Tally.new(data.map { _1[index] })
          gamma << tally.most_frequent_value
          epsilon << tally.least_frequent_value
        end

        gamma.join.to_i(2) * epsilon.join.to_i(2)
      end

      def part2_solution
        current_range_start = 0
        current_range_end = data.length - 1
        current_digit = 0
        ##find oxygen##
        number_length.times do |current_digit|
          numbers_frequency = tally_columns(data[current_range_start..current_range_end], index, 1)
           if numbers_frequency.values.uniq.count == 1 #equality
            
           end
          # if most_frequent_number
        end
        while current_range_end > current_range_start
          tally_columns(data[current_range_start..current_range_end], )
          current_range_average = (current_range_start + current_range_end + 1) / 2.0
          first_one_index = current_range_start
          first_one_index += 1 while data[first_one_index][current_digit] != "1" && first_one_index <= current_range_end

          if first_one_index > current_range_end
          elsif first_one_index <= current_range_average
            current_range_start = first_one_index
          else
            current_range_end = first_one_index - 1
          end

          current_digit += 1
        end
        oxygen_generator = data[[current_range_start, current_range_end].max].to_i(2)

        current_range_start = 0
        current_range_end = data.length - 1
        current_digit = 0
        while current_range_end > current_range_start
          current_range_average = (current_range_start + current_range_end + 1) / 2.0
          first_one_index = current_range_start
          first_one_index += 1 while data[first_one_index][current_digit] != "1" && first_one_index <= current_range_end

          if first_one_index > current_range_end
          elsif first_one_index <= current_range_average
            current_range_end = first_one_index - 1
          else
            current_range_start = first_one_index
          end

          current_digit += 1
        end
        co2_scrubber = data[[current_range_start, current_range_end].max].to_i(2)
        oxygen_generator * co2_scrubber
      end
    end
  end
end

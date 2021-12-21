# frozen_string_literal: true

require_relative "../helpers/input_parser"

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
        number_length.times do |index| # for each bit position in the binary number
          diagnostic_reading = @data.map { _1[index] } # pick that bit for each number
                                    .tally # count the number of appeareances of 1 and 0
                                    .sort_by(&:last) # sort by appearances
                                    .map(&:first) # take the value of the bit
          gamma << diagnostic_reading.last
          epsilon << diagnostic_reading.first
        end

        gamma.join.to_i(2) * epsilon.join.to_i(2)
      end

      def part2_solution
        # #Oxygen generator computation: Search in most popular##
        current_range_start = 0
        current_range_end = data.length - 1
        current_digit = 0
        while current_range_end > current_range_start
          puts "considering digit ##{current_digit + 1}"
          puts "currently searching between #{current_range_start} and #{current_range_end}"
          puts data[current_range_start..current_range_end].to_s
          current_range_average = (current_range_start + current_range_end + 1) / 2.0
          puts "average is #{current_range_average}"
          first_one_index = current_range_start
          first_one_index += 1 while data[first_one_index][current_digit] != "1" && first_one_index <= current_range_end
          puts "first 1 is at index #{first_one_index}"

          # check if that index is closer to the start or end of the range
          if first_one_index > current_range_end
          elsif first_one_index <= current_range_average # if closer to the start, then column contains mostly 1 (or in case of equality)
            current_range_start = first_one_index # so change the range start to that number
          else # if closer to end then column contains mostly 0
            current_range_end = first_one_index - 1 # so change range end to that number - 1
          end

          current_digit += 1 # increase current digit
        end
        oxygen_generator = data[[current_range_start, current_range_end].max].to_i(2)
        puts "found oxygen generator rate: #{oxygen_generator}"

        # #CO2 Scrubber computation: Search in least popular##
        current_range_start = 0
        current_range_end = data.length - 1
        current_digit = 0
        while current_range_end > current_range_start
          puts "considering digit ##{current_digit + 1}"
          puts "currently searching between #{current_range_start} and #{current_range_end}"
          puts data[current_range_start..current_range_end].to_s
          current_range_average = (current_range_start + current_range_end + 1) / 2.0
          puts "average is #{current_range_average}"
          first_one_index = current_range_start
          first_one_index += 1 while data[first_one_index][current_digit] != "1" && first_one_index <= current_range_end
          puts "first 1 is at index #{first_one_index}"

          # check if that index is closer to the start or end of the range
          if first_one_index > current_range_end
          elsif first_one_index <= current_range_average # if closer to the start, then column contains mostly 1
            puts "column contains mostly 1"
            current_range_end = first_one_index - 1 # so change the range end to that number
          else # if closer to end then column contains mostly 0 (or in case of equality)
            puts "column contains mostly 0"
            current_range_start = first_one_index # so change range end to that number - 1
          end

          current_digit += 1 # increase current digit
        end
        co2_scrubber = data[[current_range_start, current_range_end].max].to_i(2)
        puts "found co2 scrubber rate: #{co2_scrubber}"
        oxygen_generator * co2_scrubber
      end
    end
  end
end

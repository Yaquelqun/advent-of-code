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

      TOGGLE_BIT = {
        '0' => '1',
        '1' => '0'
      }

      attr_reader :data, :number_length

      def part1_solution
        gamma = [ ]
        epsilon = [ ]
        number_length.times do |index| # for each bit position in the binary number
          most_frequent_number = find_most_frequent_number(data, index, 0)
          puts "most frequent digit ##{index + 1} is #{most_frequent_number}"
          gamma << most_frequent_number
          epsilon << TOGGLE_BIT[most_frequent_number]
        end

        gamma.join.to_i(2) * epsilon.join.to_i(2)
      end

      def part2_solution
        current_range_start = 0
        current_range_end = data.length - 1
        current_digit = 0
        while current_range_end > current_range_start
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


      def find_most_frequent_number(list, digit_number, default)
        tally = list.map { _1[digit_number] } # pick that bit for each number
                    .tally # count the number of appeareances of 1 and 0
        return default if tally.values.uniq.count == 1 # same number of 1 and 0

        tally.sort_by(&:last) # sort by appearances
             .map(&:first) # take the value of the bit
             .last #last value is the most present value
      end
    end
  end
end

# frozen_string_literal: true

module Solvers
  # Problem:
  # Given several ranges
  # Iterate over all numbers in the range
  # save numbers that are comprised of patterns
  class FalseIdsFinder
    attr_reader :ranges

    def initialize(input: "day2")
      # Here the data is one line of "number-number" separated by ','
      @ranges = Helpers::InputParser.new(input: input)
                                    .parse_data.first # Get the line
                                    .split(",") # separate each range as strings
                                    .map { _1.split("-") } # for each string, separate both numbers
                                    .map { (_1.to_i.._2.to_i) } # rebuild the ranges with proper integers
    end

    def solve
      # puts "parts1: #{solve_part1}" 64215794229 is correct
      puts "parts2: #{solve_part2}" # 85 513 235 180 is too high
    end

    def solve_part1(false_ids = [])
      ranges.each_with_index do |range, index|
        puts "Checking range #{range.inspect}, #{index + 1}/#{ranges.length}"
        patterned_numbers = Helpers::RangePatternFinder.new(range).simple_patterned_numbers
        false_ids |= patterned_numbers
      end
      false_ids.sum
    end

    def solve_part2(false_ids = [], report = [])
      ranges.each_with_index do |range,index|
        puts "Checking range #{range.inspect}, #{index + 1}/#{ranges.length}"
        (1..max_pattern_size(range)).each do |pattern_size|
          # patterned_numbers is an array of {number: integer, pattern: integer}
          patterned_numbers = Helpers::RangePatternFinder.new(range).complex_patterned_numbers(pattern_size:)
          report << { range: , patterned_numbers: } # To help debug
          false_ids |= patterned_numbers.map { _1[:number] }
        end
      end
      check_report(report)
      false_ids.uniq.sum
    end

    # The maximum pattern size is half the digits of the highest number
    def max_pattern_size(range)
      range.last.to_s.length/2
    end

    def check_report(report)
      puts "checking report"

      # checked_numbers = []
      report.each do |range_report|
        report_range = range_report[:range]
        range_report[:patterned_numbers].each do |pattern_number|
          puts "checking #{pattern_number} in range #{report_range}"
          number = pattern_number[:number]
          puts "invalid number #{pattern_number}" if number < report_range.first || number > report_range.last
          puts "invalid number #{pattern_number}" unless number.to_s.gsub(pattern_number[:pattern].to_s, '').empty?
        end
      end
    end
  end
end

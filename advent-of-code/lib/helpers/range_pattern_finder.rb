# frozen_string_literal: true

module Helpers
  # Helper class to detect patterned numbers
  class RangePatternFinder
    attr_reader :range, :result

    def initialize(range)
      @range = range
      @result = []
    end

    # only checks for number repeated_twice
    # The idea here is pretty simple:
    # In a range of integers, the first possible pattern can be described as:
    # "the first half numbers of the first number or the range"
    # For example if a range is 129323..293846, the first possible pattern is 129
    # that means that the first "simply" patterned number is 129129, the next one 130130, then 131131 etc
    # until we cross the upper boundary of the range
    def simple_patterned_numbers
      string_first_element = range.first.to_s
      pattern = string_first_element[0..string_first_element.length / 2 - 1].to_i
      loop do
        patterned_number = (pattern.to_s * 2).to_i
        return result if patterned_number > range.last

        check_patterned_number(patterned_number, pattern)
        pattern += 1
      end
    end

    # checks for numbers repeated a bunch of times
    # The idea here is to extend the number of pattern we test in order to test
    # 1 number patterns up to "half of the last number" number pattern
    def complex_patterned_numbers
      (1..max_pattern_size).each do |pattern_size|
        pattern_loop(pattern_size)
      end
      result
    end

    private

    # This method given a pattern size
    # will test all integers of that size
    # For example if the pattern_size is 3, it'll test all numbers between 100 and 999
    # This could be optimized by:
    #   - considering the min/max of the range
    #     (if the range is 294..484, the smallest 1 number pattern is 2 and the highest 4)
    #   - excluding numbers that are themselves pattern
    #       ( in the range 10..2000, once we know that 1 is a pattern, no need to check for 11)
    # but right now its fast enough ^^"
    def pattern_loop(pattern_size)
      pattern = 10**(pattern_size - 1) # if the pattern size is 2, then the first number is 10
      loop do
        return if pattern.digits.count > pattern_size

        check_all_repetitions(pattern)
        pattern += 1
      end
    end

    # The maximum pattern size is half the digits of the highest number
    def max_pattern_size
      range.last.to_s.length / 2
    end

    # Simple method to check that a number is within the range
    def check_patterned_number(number, pattern)
      return unless range.include?(number)

      result << { number: number, pattern: pattern }
    end

    # We're going to want to repeat the pattern until it's higher than the higher range
    # Given a pattern like 12, this will test 1212, 121212, 12121212 ...
    def check_all_repetitions(pattern)
      built_pattern = pattern
      loop do
        built_pattern = (built_pattern.to_s + pattern.to_s).to_i
        check_patterned_number(built_pattern, pattern)
        return if built_pattern > range.last
      end
    end
  end
end

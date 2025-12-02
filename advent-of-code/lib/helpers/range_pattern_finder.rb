# frozen_string_literal: true

module Helpers
  # Helper class to detect patterned numbers
  class RangePatternFinder
    attr_reader :range, :result

    def initialize(range)
      @range = range
      @result = []
    end

    # only checks for number repeated_twixe
    def simple_patterned_numbers
      string_first_element = range.first.to_s
      pattern = string_first_element[0..string_first_element.length / 2 - 1].to_i
      loop do
        patterned_number = (pattern.to_s * 2).to_i
        return result if patterned_number > range.last

        check_patterned_number(patterned_number)
        pattern += 1
      end
    end

    # checks for numbers repeated a bunch of times
    def complex_patterned_numbers(pattern_size:)
      pattern = 10**(pattern_size-1) # if the pattern size is 2, then the first number is 10

      loop do
        return result.uniq if pattern.digits.count > pattern_size
         check_all_repetitions(pattern)
        pattern += 1
      end
    end

    private

    def check_patterned_number(number, pattern)
      return unless range.include?(number)

      # puts "flagging #{number}"
      result << { number: number, pattern: pattern}
    end

    # We're going to want to repeat the pattern until it's higher than the higher range
    def check_all_repetitions(pattern)
      built_pattern = pattern
      # puts "testing pattern #{pattern}"
      loop do
        # puts built_pattern
        check_patterned_number(built_pattern, pattern)
        built_pattern = (built_pattern.to_s + pattern.to_s).to_i
        return if built_pattern > range.last
      end
    end
  end
end

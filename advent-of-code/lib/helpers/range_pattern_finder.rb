# frozen_string_literal: true

module Helpers
  # Helper class to detect patterned numbers
  class RangePatternFinder
    attr_reader :range, :result

    def initialize(range)
      @range = range
      @result = []
    end

    def patterned_numbers
      pattern = first_pattern
      loop do
        patterned_number = (pattern.to_s * 2).to_i
        return result if patterned_number > range.last

        check_patterned_number(patterned_number)
        pattern += 1
      end
    end

    private

    # I hate this...
    # Basically, take the first half numbers of the integer
    def first_pattern
      string_first_element = range.first.to_s
      string_first_element[0..string_first_element.length / 2 - 1].to_i
    end

    def check_patterned_number(number)
      return unless range.include?(number)

      puts "flagging #{number}"
      result << number
    end
  end
end

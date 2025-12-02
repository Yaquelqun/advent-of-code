# frozen_string_literal: true

module Helpers
  class RangePatternFinder
    attr_reader :range

    def initialize(range)
      @range = range
    end

    def patterned_numbers
      result = []
      pattern = first_pattern
      while 1==1
        number = (pattern.to_s*2).to_i
        return result if number > range.last
        if range.include?(number)
          puts "flagging #{number}"
          result << number.to_i 
        end

        pattern += 1
      end
    end

    private
 
    # I hate this...
    # Basically, take the first half numbers of the integer
    def first_pattern
      string_first_element = range.first.to_s
      string_first_element[0..string_first_element.length/2 - 1].to_i
    end
  end
end

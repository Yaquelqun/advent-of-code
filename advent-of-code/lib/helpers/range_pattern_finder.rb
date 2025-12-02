# frozen_string_literal: true

module Helpers
  class RangePatternFinder
    attr_reader :range

    def initialize(range)
      @range = range
    end

    def patterned_numbers
      return [] if no_pattern_in_range?

      # From that point we know that the first element of the range has an even number of numbers
      result = []
      pattern = first_pattern
      while 1==1
        number = (pattern.to_s*2).to_i
        return result if number > reduced_range.last
        if reduced_range.include?(number)
          puts "flagging #{number}"
          result << number.to_i 
        end

        pattern += 1
      end
    end

    private

    # If both range borders have the same amount of number
    # and those numbers have an odd length, then we know there can't be patterns in there
    def no_pattern_in_range?
      first_element_length = range.first.to_s.length
      first_element_length.odd? && range.last.to_s.length == first_element_length
    end

    # To check less things, we can remove odd-length numbers
    # from the extremity of the range
    # (there can still be some in the middle of the range, too lazy to remove em)
    def reduced_range
      @reduced_range ||= begin
        first_element_length = range.first.to_s.length
        new_first_element = if first_element_length.odd?
                              10**first_element_length
                            else
                              range.first
                            end
        last_element_length = range.last.to_s.length
        new_last_element = if last_element_length.odd?
                            (10**(last_element_length - 1)) - 1
                          else
                            range.last
                          end

        result = (new_first_element..new_last_element)
        puts "reduced_range from #{range.inspect} to #{result.inspect}"
        result
      end
    end
 
    # I hate this...
    # Basically, take the first half numbers of the integer
    def first_pattern
      string_first_element = reduced_range.first.to_s
      string_first_element[0..string_first_element.length/2 - 1].to_i
    end
  end
end

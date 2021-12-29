# frozen_string_literal: true

module AdventOfCode2021
  module Models
    # Represents one messed up seven segment
    class SevenSegment
      attr_accessor :combinations, :output, :decoded_output, :dictionnary

      def initialize(combinations, output)
        @combinations = combinations.map{ _1.split("") }
        @output = output.map{ _1.split("") }
        @decoded_output = []
        @dictionnary = {}
        build_dictionnary
      end

      def decode_output
        @decoded_output = output.map do |encoded_segment|
          [encoded_segment, dictionnary.detect { |_, v| v.sort == encoded_segment.sort }.first]
        end
      end

      def code
        decoded_output.map(&:last)
      end

      private

      def build_dictionnary
        find_from_length
        find_nine
        find_zero
        find_six
        find_five
        find_three
        find_two
      end

      def find_from_length
        combinations.each do |combination|
          check_length(combination)
        end
      end

      def check_length(combination)
        case combination.length
        when 2
          add_to_dictionnary(1, combination)
        when 4
          add_to_dictionnary(4, combination)
        when 3
          add_to_dictionnary(7, combination)
        when 7
          add_to_dictionnary(8, combination)
        end
      end

      def add_to_dictionnary(number, combination)
        dictionnary[number] = combination
        @combinations -= [combination]
      end

      def find_zero
        mask = dictionnary[1]
        add_to_dictionnary(0, combinations.select { _1.length == 6 }.detect { mask - _1 == [] })
      end

      def find_two
        add_to_dictionnary(2, @combinations.last)
      end

      def find_three
        mask = dictionnary[1]
        add_to_dictionnary(3, combinations.detect { mask - _1 == [] })
      end

      def find_five
        mask = dictionnary[6]
        add_to_dictionnary(5, combinations.detect { _1 - mask == [] && (mask - _1).count == 1})
      end

      def find_six
        add_to_dictionnary(6, combinations.detect { _1.length == 6 })
      end

      def find_nine
        mask = dictionnary[4] | dictionnary[7]
        add_to_dictionnary(9, combinations.detect { mask - _1 == [] && (_1 - mask).count == 1})
      end
    end
  end
end

module AdventOfCode2021
  module Models
    class SevenSegment
      attr_accessor :combinations, :output, :decoded_output, :dictionnary

      def initialize(combinations, output)
        @combinations, @output = combinations.map{ _1.split('') }, output.map{ _1.split('') }
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
        merge_from_length
        find_nine
        find_zero
        find_six
        find_five
        find_three
        find_two
      end

      def merge_from_length
        combinations.each do |combination|
          case combination.length
          when 2
            dictionnary[1] = combination
            @combinations -= [combination]
          when 4
            dictionnary[4] = combination
            @combinations -= [combination]
          when 3
            dictionnary[7] = combination
            @combinations -= [combination]
          when 7
            dictionnary[8] = combination
            @combinations -= [combination]
          end
        end
      end

      def find_nine
        mask = dictionnary[4] | dictionnary[7]
        dictionnary[9] = combinations.detect { mask - _1 == [] && (_1 - mask).count == 1}
        @combinations -= [dictionnary[9]]
      end

      def find_zero
        mask = dictionnary[1]
        dictionnary[0] = combinations.select { _1.length == 6 }.detect { mask - _1 == [] }
        @combinations -= [dictionnary[0]]
      end

      def find_six
      dictionnary[6] = combinations.detect { _1.length == 6 }
      @combinations -= [dictionnary[6]]
      end

      def find_five
      mask = dictionnary[6]
      dictionnary[5] = combinations.detect { _1 - mask == [] && (mask - _1).count == 1}
      @combinations -= [dictionnary[5]]
      end

      def find_three
      mask = dictionnary[1]
      dictionnary[3] = combinations.detect { mask - _1 == [] }
      @combinations -= [dictionnary[3]]
      end

      def find_two
        dictionnary[2] = @combinations.last
      end
    end
  end
end

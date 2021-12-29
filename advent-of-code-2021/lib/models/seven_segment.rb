module AdventOfCode2021
  module Models
    class SevenSegment
      attr_accessor :combinations, :output, :decoded_output

      def initialize(combinations, output)
        @combinations, @output = combinations, output
        @decoded_output = []
      end

      def decode_output
        output.each do |segment_string|
          decoded_value = case segment_string.length
                          when 2
                            increment
                            1
                          when 4
                            increment
                            4
                          when 3
                            increment
                            7
                          when 7
                            increment
                            8
          end
          decoded_output << [segment_string, decoded_value]
        end
        decoded_output
      end

      def code
        decoded_output.map(&:last)
      end
    end
  end
end

# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2022
  module Solvers
    # finds low points in height map
    class CommunicationPacketParser
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day6_input").parse_data[0].split("")
      end

      def solve
        puts "start of packet position with header length 4: #{find_start_of_message(header_length: 4)}" # Solution: 1287
        puts "start of packet position with header length 14: #{find_start_of_message(header_length: 14)}" # Solution: 3716
      end

      private

      attr_reader :data

      def find_start_of_message(header_length:)
        buffer = data[0..(header_length - 1)]
        data[header_length..].each.with_index(header_length) do |letter, result|
          return result if buffer.uniq == buffer

          buffer << letter
          buffer.shift
        end
      end
    end
  end
end

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
        puts "start of packet position: #{solve_part1}" # Solution: 
      end

      private

      attr_reader :data

      def solve_part1
        buffer = data[0..3]
        data[4..].each.with_index(4) do |letter, result|
          return result if buffer.uniq == buffer

          buffer << letter
          buffer.shift
        end
      end
    end
  end
end

# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # Extends a polymer according to rules
    class PolymerInserter
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day14_input").parse_data
      end

      def solve
        puts "most - least common element after 10 steps: #{part1_solution}" # Solution: 2435
        @polymer = nil
        # puts ":#{part2_solution}" # Solution:
      end

      private

      attr_reader :data

      def part1_solution
        10.times do |step|
          puts '###########'
          puts step
          expand_polymer
        end

        element_occurrences = polymer.tally.values.sort
        element_occurrences.last - element_occurrences.first
      end

      def part2_solution
        40.times do |step|
          puts '###########'
          puts step
          expand_polymer
        end

        element_occurrences = polymer.tally.values.sort
        element_occurrences.last - element_occurrences.first
      end

      def expand_polymer
        pointer = 0
        until polymer[pointer + 1].nil?
          couple = polymer[pointer..(pointer + 1)].join
          new_element = rules[couple]
          pointer += 1 && next if new_element.nil?

          polymer.delete_at(pointer)
          polymer.delete_at(pointer)
          new_element.reverse.each { polymer.insert(pointer, _1) }

          pointer += 2
        end
      end

      def polymer
        @polymer ||= data.first.split('')
      end

      def rules
        @rules ||= begin
          h = data[2..].map { _1.split(' -> ') }.to_h
          h.each { |k, v| h[k] = [k[0], v, k[1]] }
        end
      end
    end
  end
end

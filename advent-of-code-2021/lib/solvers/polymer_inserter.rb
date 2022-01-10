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
        10.times { expand_rules }
        puts "most - least common element after 10 steps: #{part1_solution}" # Solution: 2435
        @submarine_polymer = nil
        puts ":#{part2_solution}" # Solution:
      end

      private

      attr_reader :data

      def part1_solution
        10.times do |step|
          puts '###########'
          puts step
          expand_polymer
        end
        
        element_occurrences = submarine_polymer.tally.values.sort
        element_occurrences.last - element_occurrences.first
      end
      
      def part2_solution
        40.times do |step|
          puts '###########'
          puts step
          expand_polymer
        end

        element_occurrences = submarine_polymer.tally.values.sort
        element_occurrences.last - element_occurrences.first
      end

      def expand_polymer(polymer = submarine_polymer)
        pointer = 0
        until polymer[pointer + 1].nil?
          end_pointer = find_largest_known_pattern(polymer, pointer)
          pointer += 1 && next if end_pointer == pointer

          couple = polymer[pointer..end_pointer].join
          new_element = rules[couple]

          couple.length.times { polymer.delete_at(pointer) }
          new_element.reverse.each { polymer.insert(pointer, _1) }

          pointer += new_element.length - 1
        end
      end

      def find_largest_known_pattern(polymer, pointer)
        end_pointer = pointer
        until polymer[end_pointer + 1].nil?
          pattern = polymer[(pointer..(end_pointer + 1))].join
          return end_pointer unless rules.key?(pattern)

          end_pointer += 1
        end
        end_pointer
      end

      def submarine_polymer
        @submarine_polymer ||= data.first.split('')
      end

      def rules
        @rules ||= begin
          h = data[2..].map { _1.split(' -> ') }.to_h
          h.each { |k, v| h[k] = [k[0], v, k[1]] }
        end
      end

      def expand_rules
        new_rules = {}
        rules.each do |_, value|
          next unless rules[value].nil?
          
          expanded_value = value.dup
          expand_polymer(expanded_value)
          new_rules[value.join] = expanded_value
        end

        rules.merge! new_rules
      end
    end
  end
end

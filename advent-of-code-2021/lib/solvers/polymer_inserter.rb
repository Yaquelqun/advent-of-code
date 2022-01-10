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
        # puts "most - least common element after 40 steps:#{part2_solution}" # Solution:
      end

      private

      attr_reader :data

      def part1_solution
        submarine_polymer = initial_submarine_polymer
        10.times do |step|
          puts '###########'
          puts step
          # puts "new_added_patterns: #{@added_patterns}"
          # puts "rule_book size: #{rules.keys.size}"
          # puts "largest_key: #{rules.keys.map(&:size).max}"
          # puts "polymer_size size: #{submarine_polymer.size}"
          # @added_patterns = 0
          expand_polymer
        end

        element_occurrences = submarine_polymer.tally.values.sort
        element_occurrences.last - element_occurrences.first
      end
      
      def part2_solution
        40.times do |step|
          puts '###########'
          puts step
          puts "new_added_patterns: #{@added_patterns}"
          puts "rule_book size: #{rules.keys.size}"
          puts "largest_key: #{rules.keys.map(&:size).max}"
          puts "polymer_size size: #{submarine_polymer.size}"

          @added_patterns = 0
          expand_polymer
        end

        element_occurrences = submarine_polymer.tally.values.sort
        element_occurrences.last - element_occurrences.first
      end

      def expand_polymer(polymer = submarine_polymer, expanding_rules = false)
        pointer = 0
        until polymer[pointer + 1].nil?
          print "pointer at #{pointer}/#{polymer.length}" + "\r" unless expanding_rules
          end_pointer = find_largest_known_pattern(polymer, pointer)
          if end_pointer == pointer
            pointer += 1
            next
          end
          
          couple = polymer[pointer..end_pointer].join
          new_element = rules[couple]
          # puts "found pattern of size #{couple.length}" if !expanding_rules && couple.length > 1000

          couple.length.times { polymer.delete_at(pointer) }
          new_element.reverse.each { polymer.insert(pointer, _1) }
          add_to_rules(new_element) unless expanding_rules

          pointer += new_element.length - 1
        end
        puts "expansion completed" unless expanding_rules
      end
      
      def initial_submarine_polymer
        polymer = Hash.new(0)
        parsed_data = data.first.split('')
        parsed_data.map.with_index { |c, index| [c, parsed_data[index + 1]] }[..-2]
        .each { polymer[_1] += 1 }
        polymer # count of the pairs of adjacent characters: "KBP..." becomes { [K, B] => 1, [B, P] => 1 ...}
      end

      def rules
        @rules ||= begin
          rules = {}
          h = data[2..].map { _1.split(' -> ') }.to_h
          h.each { |k, v| rules[k.split('')] = [[k[0], v], [v, k[1]]] } # OP -> H becomes [O,P] => [[O, H], [H, P]]
          rules
        end
      end
    end
  end
end

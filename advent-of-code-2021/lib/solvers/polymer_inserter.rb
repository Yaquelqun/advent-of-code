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
        @submarine_polymer = nil
        puts ":#{part2_solution}" # Solution:
      end

      private

      attr_reader :data

      def part1_solution
        10.times do |step|
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

      def find_largest_known_pattern(polymer, pointer)
        end_pointer = pointer + 1
        result = pointer
        largest_rule = rules.keys.map(&:size).max

        until polymer[end_pointer].nil? || (end_pointer - pointer) >= largest_rule
          pattern = polymer[pointer..end_pointer].join
          result = end_pointer if rules[pattern]
          end_pointer += 1
        end
        result
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

      def add_to_rules(new_element)
        return if rules.key?(new_element.join) || new_element.length >= 900

        @added_patterns += 1
        expanded_value = new_element.dup
        expand_polymer(expanded_value, true)
        rules[new_element.join] = expanded_value
      end
    end
  end
end

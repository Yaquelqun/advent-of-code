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
        puts "most - least common element after 10 steps: #{run_steps(10)}" # Solution: 2435
        puts "most - least common element after 40 steps: #{run_steps(40)}" # Solution: 2587447599164
      end

      private

      attr_reader :data

      def run_steps(steps)
        submarine_polymer = initial_submarine_polymer
        submarine_polymer = expand_polymer(submarine_polymer, steps)
        tally = sum_letters(submarine_polymer)

        tally.last - tally.first - 1
      end

      def expand_polymer(polymer, steps)
        steps.times do
          expanded_polymer = Hash.new(0)
          polymer.each do |pair, amount|
            next unless rules.key?(pair)

            rules[pair].each { expanded_polymer[_1] += amount }
          end
          polymer = expanded_polymer
        end

        polymer
      end

      def sum_letters(polymer)
        element_occurrences = Hash.new(0)
        polymer.each do |couple, amount|
          element_occurrences[couple[0]] += amount
        end
        element_occurrences.values.sort
      end

      def initial_submarine_polymer
        polymer = Hash.new(0)
        parsed_data = data.first.split("")
        parsed_data.map.with_index { |c, index| [c, parsed_data[index + 1]] }[..-2]
                   .each { polymer[_1] += 1 }
        polymer # count of the pairs of adjacent characters: "KBP..." becomes { [K, B] => 1, [B, P] => 1 ...}
      end

      def rules
        @rules ||= begin
          rules = {}
          h = data[2..].map { _1.split(" -> ") }.to_h
          h.each { |k, v| rules[k.split("")] = [[k[0], v], [v, k[1]]] } # OP -> H becomes [O,P] => [[O, H], [H, P]]
          rules
        end
      end
    end
  end
end

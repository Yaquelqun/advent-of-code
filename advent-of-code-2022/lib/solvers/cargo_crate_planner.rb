require_relative "../helpers/input_parser"

module AdventOfCode2022
  module Solvers
    class CargoCratePlanner
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day5_input")
                                   .parse_data
        initialize_variables
      end

      def solve
        puts "top stacks after single move instructions: #{move_crates(strategy: "single_move")}" # Solution JCMHLVGMG
        initialize_variables
        puts "top stacks after multiple move: #{move_crates(strategy: "multiple_move")}" # Solution LVMRWSSPZ
      end

      private

      attr_accessor :stacks
      attr_reader :instructions, :data

      def move_crates(strategy:)
        instructions.each { apply_instruction(_1, strategy)}
        stacks.values.map(&:first).join
      end

      def apply_instruction(instruction, strategy = "multiple_move")
        to_move = stacks[instruction[:from]].shift(instruction[:move_count])
        to_move.reverse! if strategy == "single_move"
        stacks[instruction[:to]] = to_move + stacks[instruction[:to]]
      end

      def initialize_variables
        @stacks, @instructions = separate_data(data).map { |k, v| send("parse_#{k}", v) }
      end

      def separate_data(data)
        separation_line = data.index("")

        { "stacks" => data[..(separation_line - 1)], "instructions" => data[(separation_line + 1)..] }
      end

      def parse_stacks(input)
        stacks = Hash.new([])
        stack_names = input[-1]
        stack_lines = input[..-2]
        i = 1

        until stack_names[i].nil?
          stack_name = stack_names[i]
          stacks[stack_name] = stack_lines.map { _1[i] }
          i += 4
        end

        stacks.transform_values { _1 - [" "]}.transform_keys(&:to_i)
      end

      def parse_instructions(input)
        input.map { /move (\d*) from (\d*) to (\d*)/.match(_1) }
             .map { { move_count: _1[1], from: _1[2], to: _1[3] } }
             .map { _1.transform_values(&:to_i) }
      end
    end
  end
end

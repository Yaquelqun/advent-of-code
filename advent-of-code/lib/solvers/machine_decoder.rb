# frozen_string_literal: true

module Solvers
  # Problem:
  # - Part 1: Given a final arrray containing trues and falses + a list of actions toggling
  # array positions, find the smallest combination of buttons to press to get to the final array
  # from an all false array
  class MachineDecoder
    attr_reader :machines

    def initialize(input: "day10")
      # get each line and split them into single chars
      @machines = Helpers::InputParser.new(input: input)
                                      .parse_data
                                      .map { Helpers::FactoryMachine.new(_1) }
    end

    def solve
      puts "parts1: #{solve_part1}" # 409 is correct
      puts "parts2: #{solve_part2}" # is correct
    end

    def solve_part1
      machines.map(&:solve_for_state).sum
    end

    def solve_part2
      machines.map(&:solve_for_joltage).sum
    end
  end
end

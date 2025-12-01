# frozen_string_literal: true

# Day1 solver
module Solvers
  class SafePasswordDecryptor
    attr_reader :steps

    def initialize(input: "day1")
      @steps = Helpers::InputParser.new(input: input)
                                   .parse_data
                                   .map { |step| [step[0], step[1..]] }
                                   .map { |direction, amount| [direction == "L" ? "-" : "+", amount.to_i] }
    end

    def solve
      puts "parts1: #{solve_part1}"
      puts "parts2: #{solve_part2}"
    end

    def solve_part1
      result = 0
      position = 50
      steps.each do |direction, amount|
        movement_result = move_dial(position, direction, amount)
        puts "result: #{movement_result}"
        position = movement_result[:final_position]
        result += 1 if position.zero?
      end

      result
    end

    def solve_part2
      result = 0
      position = 50
      steps.each do |direction, amount|
        movement_result = move_dial(position, direction, amount)
        puts "result: #{movement_result}"
        position = movement_result[:final_position]
        result += 1 if position.zero?
        result += movement_result[:complete_turns]
        result += 1 if movement_result[:crossed_zero]
      end
      result
    end

    def move_dial(position, direction, amount)
      complete_turns = amount / 100
      remainder = amount.remainder(100)
      final_position = position.send(direction, remainder) % 100
      crossed_zero = crossed_zero?(direction, position, final_position)
      {
        position:,
        direction:,
        amount:,
        final_position:, 
        complete_turns:,
        crossed_zero: 
      }
    end

    def crossed_zero?(direction, position, final_position)
      return false if position.zero? || final_position.zero?

      (direction == '+'  && final_position < position) || (direction == '-' && final_position > position)
    end
  end
end

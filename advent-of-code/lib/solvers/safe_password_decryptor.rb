# frozen_string_literal: true

module Solvers
  # Problem:
  # A safe rotary dial starts at 50, and we have a list of operations
  # that contain a direction and movement range (how much we turn the dial)
  # Given those information:
  # - compute how many times the dial ended up on 0
  # - compute how many times the dial ended up or crossed 0 while turning
  class SafePasswordDecryptor
    attr_reader :steps

    def initialize(input: "day1")
      # The input is a bunch of lines with one char and a number per line (like "R1234 or L23")
      # The goal is to turn them into a an array of arrays with an operation and a number
      # like [['+', 1234], ['-, 23']] so it's easy to make the computations later
      @steps = Helpers::InputParser.new(input: input)
                                   .parse_data
                                   .map { |step| [step[0], step[1..]] }
                                   .map { |direction, amount| [direction == "L" ? "-" : "+", amount.to_i] }
    end

    def solve
      puts "parts1: #{solve_part1}"
      puts "parts2: #{solve_part2}"
    end

    def solve_part1(result = 0, position = 50)
      steps.each do |direction, amount|
        movement_result = move_dial(position, direction, amount)
        puts "result: #{movement_result}"
        position = movement_result[:final_position]
        result += 1 if position.zero?
      end

      result
    end

    def solve_part2(result = 0, position = 50)
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

    # This method simulates the movement of the dial
    def move_dial(position, direction, amount)
      complete_turns = amount / 100 # Complete turns are irrelevant until part 2
      remainder = amount.remainder(100) # Remainder is the real movement
      # since we precomputed L/R into +/-, send is really cool now =D
      final_position = position.send(direction, remainder) % 100
      crossed_zero = crossed_zero?(direction, position, final_position) # relevant for part 2
      { position:, direction:, amount:, final_position:,
        complete_turns:, crossed_zero: }
    end

    # This method checks if the idial crossed 0
    def crossed_zero?(direction, position, final_position)
      # if started or ended up on 0, we technically didn't cross it
      return false if position.zero? || final_position.zero?

      # Looking at a dial,
      # assuming that we haven't done more than a full turn (which we know since we removed them with complete_turns)
      # we know that we crossed 0 if the dial end up before where it was going forward
      # or after where it was going backward
      # There's gotta be a better way of doing this, but it's getting late :p
      (direction == "+" && final_position < position) || (direction == "-" && final_position > position)
    end
  end
end

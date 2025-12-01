# frozen_string_literal: true

# Day1 solver
module Solvers
  class SafePasswordDecryptor
    attr_reader :steps

    def initialize
      @steps = Helpers::InputParser.new(endpoint: "day1")
                                   .parse_data
                                   .map { |step| [step[0], step[1..]] }
                                   .map { |direction, amount| [direction == "L" ? "-" : "+", amount.to_i] }
    end

    def solve
      puts "parts1: #{solve_part1}"
    end

    private

    def solve_part1
      result = 0
      position = 50
      steps.each do |direction, amount|
        # print "#{position} #{direction} #{amount} = "
        position = position.send(direction, amount) % 100
        # print "#{position} \n"
        result += 1 if position.zero?
      end

      result
    end
  end
end

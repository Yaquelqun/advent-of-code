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
        # print "#{position} #{direction} #{amount} = "
        position = position.send(direction, amount) % 100
        # print "#{position} \n"
        result += 1 if position.zero?
      end

      result
    end

    def solve_part2
      result = 0
      position = 50
      started_at0 = false
      steps.each do |direction, amount|
        print "#{position} #{direction} #{amount} = "
        position = position.send(direction, amount)
        print "#{position} \n"
        if !started_at0 && position > 100
          to_add = position / 100
          puts "adding #{to_add} 'cause it crossed 0 #{to_add} times"
          result += to_add
        elsif !started_at0 && position.negative?
          to_add = 1 + (position / 100).abs
          puts "adding #{to_add} 'cause it crossed 0 #{to_add} times"
          result += to_add
        end

        position %= 100
        if position.zero?
          started_at0 = true
          puts "adding 1 'cause it ended at 0"
          to_add = 1 + (amount /100)
          puts "adding another #{to_add} since we made another #{to_add} turns"
          result += 1
        else
          started_at0 = false
        end
      end
      result
    end
  end
end

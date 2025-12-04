# frozen_string_literal: true

module Solvers
  # Problem
  # Given several lines of digits,
  # make the highest 2 digits number where the first
  # digits is before the second one
  class JolterComputer
    attr_reader :banks

    def initialize(input: "day3")
      # get each line and split them into single digits
      @banks = Helpers::InputParser.new(input: input)
                                   .parse_data
                                   .map { _1.split("").map(&:to_i) }
    end

    def solve
      # puts "parts1: #{solve_part1}" # 17412 is correct
      puts "parts2: #{solve_part2}" # 172681562473501 is correct
    end

    def solve_part1
      banks.dup.sum do |bank|
        puts "checking bank #{bank}"
        jolter_bank = ::Helpers::JolterBank.new(bank, 2)
        resolve_bank(jolter_bank)
      end
    end

    def solve_part2
      banks.dup.sum do |bank|
        puts "checking bank #{bank}"
        jolter_bank = ::Helpers::JolterBank.new(bank, 12)
        resolve_bank(jolter_bank)
      end
    end

    private

    def resolve_bank(jolter_bank)
      jolter_bank.initialize_ouput
      puts "bank initialize with input #{jolter_bank.input_bank} and ouput #{jolter_bank.output_bank}"
      jolter_bank.advance until jolter_bank.empty?
      jolter_bank.integer_output
    end
  end
end

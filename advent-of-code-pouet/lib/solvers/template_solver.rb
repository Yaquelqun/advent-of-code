# frozen_string_literal: true

# Day1 solver
module Solvers
  class TemplateSolver

    def initialize(endpoint: "template_input")
      @steps = Helpers::InputParser.new(endpoint:)
                                   .parse_data
    end

    def solve
      puts "parts1: #{solve_part1}"
      puts "parts2: #{solve_part2}"
    end

    def solve_part1
      'done1'
    end

    def solve_part2
      'done2'
    end
  end
end
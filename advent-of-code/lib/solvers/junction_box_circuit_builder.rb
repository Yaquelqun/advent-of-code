# frozen_string_literal: true

module Solvers
  # Problem: Given a list of 3 dimension coordinates:
  # Find the 1000 pairs of closest points and link them
  # Once the pairs are linked, multiply the length of all created circuitss
  class JunctionBoxCircuitBuilder
    attr_reader :boxes

    def initialize(input: "day8")
      # get each line and split them into coordinates
      @boxes = Helpers::InputParser.new(input: input)
                                   .parse_data
                                   .map { _1.split(",") }
                                   .map { Helpers::JunctionBox.new(*_1) }
    end

    def solve
      puts "parts1: #{solve_part1}" # 66640 is correct
      puts "parts2: #{solve_part2}" # is correct
    end

    def solve_part1(result: 0, connection_count: 1000)
      ordered_pairs = ::Helpers::JunctionBoxes::DistanceComputer.new(boxes, connection_count)
                                                                .ordered_pairs

      circuits = ::Helpers::JunctionBoxes::CircuitBuilder.new(ordered_pairs)
                                                         .build_circuits
      puts " circuit_size = #{circuits.values.map(&:size)}"
      circuits.values
              .map(&:size)
              .sort.reverse
              .first(3)
              .reduce(&:*)
    end

    def solve_part2(result = 0)
    end
  end
end

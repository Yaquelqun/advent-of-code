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
      @boxes.map(&:reset_circuit)
      puts "parts2: #{solve_part2}" # 70058541 is too low
    end

    def solve_part1(connection_count: 1000)
      ordered_pairs = ::Helpers::JunctionBoxes::DistanceComputer.new(boxes, connection_count)
                                                                .ordered_pairs

      circuits = ::Helpers::JunctionBoxes::CircuitBuilder.new(ordered_pairs, boxes.count)
                                                         .build_circuits(stop_condition: :end_of_input)
      circuits.values
              .map(&:size)
              .sort.reverse
              .first(3)
              .reduce(&:*)
    end

    def solve_part2
      ordered_pairs = ::Helpers::JunctionBoxes::DistanceComputer.new(boxes, nil)
                                                                .ordered_pairs
      first_box, second_box = ::Helpers::JunctionBoxes::CircuitBuilder.new(ordered_pairs, boxes.count)
                                                                      .build_circuits(stop_condition: :single_circuit)
      first_box.x * second_box.x
    end
  end
end

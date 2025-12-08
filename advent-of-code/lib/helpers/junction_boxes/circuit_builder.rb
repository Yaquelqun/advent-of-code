# frozen_string_literal: true

module Helpers
  module JunctionBoxes
    # Iterates over the pairs and put them in circuits
    class CircuitBuilder
      attr_reader :circuits, :pairs

      def initialize(pairs)
        @pairs = pairs
        @circuits = Hash.new([])
      end

      def build_circuits
        circuit_index = 1
        pairs.each do |first_box, second_box|
          case [first_box.circuit, second_box.circuit]
          in [nil, nil] # No box are in any circuit
            add_boxes_to_circuit(first_box, second_box, circuit_index:)
            circuit_index += 1
          in [Integer => ci, ^ci] # Both boxes are in the same circuit
          in [Integer => cia, nil] # only one of the boxes is in a circuit
            add_boxes_to_circuit(second_box, circuit_index: cia)
          in [nil, Integer => cib]
            add_boxes_to_circuit(first_box, circuit_index: cib)
          in [Integer => cia, Integer => cib] if cib != cia # Both boxes are in different circuits
            add_boxes_to_circuit(first_box, *circuits[cib], circuit_index: cia)
            circuits[cib] = [] # Reset circuit b
          else
            raise "unknown pattern caught #{first_box.circuit}, #{second_box.circuit}"
          end
        end
        circuits
      end

      private

      def add_boxes_to_circuit(*boxes, circuit_index:)
        boxes.each { |box| box.circuit = circuit_index }
        circuits[circuit_index] |= boxes
      end
    end
  end
end

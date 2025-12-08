# frozen_string_literal: true

module Helpers
  module JunctionBoxes
    # Iterates over the pairs and put them in circuits
    class CircuitBuilder
      attr_reader :circuits, :pairs, :circuit_index, :box_count

      def initialize(pairs, box_count)
        @pairs = pairs
        @box_count = box_count
        @circuits = Hash.new([])
        @circuit_index = 1
      end

      def build_circuits(stop_condition:)
        pairs.each do |first_box, second_box|
          connect(first_box, second_box)
          circuits.reject! { _2.empty? } # remove empty circuits due to merging
          return [first_box, second_box] if stop_condition == :single_circuit && circuits.values.count == 1 && circuits.values.first.count == box_count
        end
        circuits
      end

      private

      # Heavy lifting method
      def connect(first_box, second_box)
        case [first_box.circuit, second_box.circuit]
        in [nil, nil] # No box are in any circuit
          add_boxes_to_circuit(first_box, second_box, index: circuit_index)
          @circuit_index += 1
        in [Integer => ci, ^ci] # Both boxes are in the same circuit, nothing to do
        in [Integer => cia, nil] # only one of the boxes is in a circuit
          add_boxes_to_circuit(second_box, index: cia)
        in [nil, Integer => cib]
          add_boxes_to_circuit(first_box, index: cib)
        in [Integer => cia, Integer => cib] if cib != cia # Both boxes are in different circuits
          add_boxes_to_circuit(first_box, *circuits[cib], index: cia)
          circuits[cib] = [] # Reset circuit b
        else
          raise "unknown pattern caught #{first_box.circuit}, #{second_box.circuit}"
        end
      end

      def add_boxes_to_circuit(*boxes, index:)
        boxes.each { |box| box.circuit = index }
        circuits[index] |= boxes
      end
    end
  end
end

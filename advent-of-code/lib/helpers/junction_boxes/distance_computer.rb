# frozen_string_literal: true

module Helpers
  module JunctionBoxes
    # Class that takes in a list of coordinates and
    # computes the distance between them all before returning an ordered list of pairs
    class DistanceComputer
      PairWithDistance = Struct.new(:pair, :distance)

      attr_reader :boxes, :pair_count

      def initialize(boxes, pair_count = nil)
        @boxes = boxes
        @pair_count = pair_count
      end

      def ordered_pairs
        result = []
        boxes.combination(2) do |first_box, second_box|
          result << PairWithDistance.new([first_box, second_box], first_box.distance_to(second_box))
        end
        result = result.sort_by(&:distance)
        result = result.first(pair_count) if pair_count
        result.map(&:pair)
      end
    end
  end
end

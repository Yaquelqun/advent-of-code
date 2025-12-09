# frozen_string_literal: true

module Helpers
  module Points
    # Class that takes in a list of coordinates and
    # computes the distance between them all before returning an ordered list of pairs
    class DistanceComputer
      PairWithData = Struct.new(:pair, :distance, :area, keyword_init: true)

      attr_reader :points, :pair_count, :pairing_method

      def initialize(points, pair_count = nil, pairing_method: :distance)
        @points = points
        @pair_count = pair_count
        @pairing_method = pairing_method
        @result = []
      end

      def ordered_pairs
        points.combination(2) do |first_point, second_point|
          send("enrich_with_#{pairing_method}", first_point, second_point)
        end
        @result = @result.sort_by(&pairing_method)
        @result = @result.first(pair_count) if pair_count
        @result
      end
    end

    private

    def enrich_with_distance(first_point, second_point)
      @result << PairWithData.new(pair: [first_point, second_point], distance: first_point.distance_to(second_point))
    end

    def enrich_with_area(first_point, second_point)
      area = ((first_point.y - second_point.y).abs + 1) * ((first_point.x - second_point.x).abs + 1)
      @result << PairWithData.new(pair: [first_point, second_point], area: area)
    end
  end
end

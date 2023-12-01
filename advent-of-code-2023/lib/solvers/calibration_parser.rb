# frozen_string_literal: true

module Solvers
  class CalibrationParser
    attr_reader :inputs

    def initialize
      @inputs = Helpers::InputParser.new(endpoint: "day1").parse_data
    end

    def solve
      puts "part 1: #{calibration_values.sum}" # 54450
    end

    private

    def calibration_values
      # any character .to_s returns 0 unless it's an integer
      @calibration_values ||= inputs.map { (_1.split("").map(&:to_i) - [0]) }
                                    .map { [_1[0], _1[-1]].join.to_i }
    end
  end
end

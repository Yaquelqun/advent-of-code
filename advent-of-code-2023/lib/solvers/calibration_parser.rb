# frozen_string_literal: true

module Solvers
  class CalibrationParser
    attr_reader :inputs

    def initialize
      @inputs = Helpers::InputParser.new(endpoint: "day1").parse_data
    end

    def solve
      puts "part 1: #{strict_calibration_values(inputs).sum}" # 54450
      puts "part 2: #{loose_calibration_values.sum}" # 54265
    end

    private

    def strict_calibration_values(calibrations)
      # any character .to_s returns 0 unless it's an integer
      calibrations.map { (_1.split("").map(&:to_i) - [0]) }
                  .map { [_1[0], _1[-1]].join.to_i }
    end

    def loose_calibration_values
      strict_calibration_values(inputs.map { |input| translate_numbers.call(translate_numbers.call(input)) })
    end

    NUMBER_DICT = {
      "one" => "o1e",
      "two" => "t2o",
      "three" => "t3e",
      "four" => "f4r",
      "five" => "f5e",
      "six" => "s6x",
      "seven" => "s7n",
      "eight" => "e8t",
      "nine" => "n9e"
    }.freeze

    def translate_numbers
      -> { _1.gsub(/(#{NUMBER_DICT.keys.join("|")})/, **NUMBER_DICT) }
    end
  end
end

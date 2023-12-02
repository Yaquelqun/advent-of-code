# frozen_string_literal: true

class CubeGame
  attr_reader :report

  def initialize(game_report)
    @report = game_report
  end

  def id
    @id ||= report.match(/Game (\d*):/)[1].to_i
  end

  def max_red
    @max_red ||= reds.max
  end

  def max_green
    @max_green ||= greens.max
  end

  def max_blue
    @max_blue ||= blues.max
  end

  def power
    @power ||= max_red * max_blue * max_green
  end

  private

  def reds
    @reds ||= report.scan(/(\d+) red/).map { _1[0].to_i }
  end

  def blues
    @blues ||= report.scan(/(\d+) blue/).map { _1[0].to_i }
  end

  def greens
    @greens ||= report.scan(/(\d+) green/).map { _1[0].to_i }
  end
end

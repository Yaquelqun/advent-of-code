# frozen_string_literal: true

require_relative "advent_of_code_2024/day_solver"

# main module
module AdventOfCode2024
  class Error < StandardError; end

  def self.run
    return puts "You checked out from the template, good luck for this year ^^" if name.include? "2024"

    puts "Advent of Code 2024"
    puts "what day do you want the solution to ?"
    DaySolver.new(gets.chomp.to_i).solve
  end
end

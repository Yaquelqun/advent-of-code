# frozen_string_literal: true

require_relative "advent_of_code_2023/day_solver"

# main module
module AdventOfCode2023
  class Error < StandardError; end

  def self.run
    return puts "You checked out from the template, good luck for this year ^^" if name.include? "Pouet"

    puts "Advent of Code 2023"
    puts "what day do you want the solution to ?"
    DaySolver.new(gets.chomp.to_i).solve
  end
end

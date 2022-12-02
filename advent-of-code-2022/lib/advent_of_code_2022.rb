# frozen_string_literal: true

require_relative "advent_of_code_2022/day_solver"

# main module
module AdventOfCode2022
  class Error < StandardError; end

  def self.run
    return puts "You checked out from the template, good luck for this year ^^" if name.include? "pouet"

    puts "Advent of Code 2022"
    puts "what day do you want the solution to ?"
    DaySolver.new(gets.chomp.to_i).solve
  end
end

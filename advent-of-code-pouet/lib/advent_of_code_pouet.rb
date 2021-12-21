# frozen_string_literal: true

require_relative "advent_of_code_pouet/day_solver"

# main module
module AdventOfCodePouet
  class Error < StandardError; end

  def self.run
    return puts "You checked out from the template, good luck for this year ^^" if name.include? "Pouet"

    puts "Advent of Code Pouet"
    puts "what day do you want the solution to ?"
    DaySolver.new(gets.chomp.to_i).solve
  end
end

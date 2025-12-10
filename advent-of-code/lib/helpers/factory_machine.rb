# frozen_string_literal: true

module Helpers
  # helper class to keep the factory machine logic in one place
  class FactoryMachine
    attr_reader :final_state, :buttons, :joltages

    def initialize(string_input)
      initialize_parts(string_input)
    end

    # Just tryna bruteforce my way for now
    def solve_for_state
      ideal_button = final_state.map.with_index { _2 if _1 == true }.compact # Button i'm looking for
      (1..buttons.count).each do |combination_size|
        puts "testing all #{combination_size} combinations"
        buttons.combination(combination_size).each do |button_combination|
          # byebug if combination_size == 2
          resolving_button = button_combination.flatten.tally.to_a.select {_2.odd?}.map(&:first)
          if resolving_button.sort == ideal_button.sort
            puts "resolved in #{combination_size} buttons: #{button_combination.inspect}"
            return combination_size
          end
        end
      end
    end

    def solve_for_joltage
      solutions = new_solutions
      button_pressed = 0
      loop do
        puts "testing #{solutions.size} solutions with #{button_pressed} buttons pressed"
        current_solutions = solutions.flatten
        # current_solutions = current_solutions.uniq { _1[:state] } if button_pressed > 0
        solutions = []
        current_solutions.map do |solution|
          solution[:state] = solution[:state].map.with_index {solution[:new_button].include?(_2) ? _1 + 1 : _1 }
          solution[:buttons_pressed] += [solution[:new_button]]
          if solution[:state] == joltages
            puts "resolved in #{solution[:buttons_pressed].count} buttons: #{solution[:buttons_pressed].inspect}"
            return solution[:buttons_pressed].count
          else
            solution
          end
        end
        solutions = current_solutions.uniq { _1[:state] }.flat_map { new_solutions(_1) }
        button_pressed += 1
      end
    end

    private

    # generate solutions from ideal button
    def new_solutions(previous_solution = {})
    potential_buttons = if previous_solution[:state]
                          done_indices = previous_solution[:state].zip(joltages)
                                                                  .map.with_index { |comb, index| index if comb.uniq.count == 1  }
                                                                  .compact
                          buttons.reject { |button| (button & done_indices).any? }
                        else
                          buttons
                        end 
      potential_buttons.map do |button|
        solution = {
          state: previous_solution[:state] || empty_joltage,
          buttons_pressed: previous_solution[:buttons_pressed] || [],
          new_button: button
        }
        solution
      end
    end

    def empty_joltage
      Array.new(joltages.size) { 0 }
    end
    def initialize_parts(raw_input)
      # split the input into 3 parts
      raw_final_state, raw_buttons, joltages = /(\[.*\]) (.*) ({.*})/.match(raw_input).to_a[1..]
      # treat first part: [..#..#..#...] to turn it into [false, false true ....]
      @final_state = raw_final_state[1..-2].split("").map { { "." => false, "#" => true }[_1] }
      # treat second part: (1) (2,3) (5,3,4) to turn it into [[1], [2, 3], [5, 3, 4]]
      @buttons = raw_buttons.split.map { _1[1..-2].split(",").map(&:to_i).sort }
      # treat last part.
      @joltages = joltages[1..-2].split(",").map(&:to_i)
    end
  end
end

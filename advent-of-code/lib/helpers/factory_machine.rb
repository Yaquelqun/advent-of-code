# frozen_string_literal: true

module Helpers
  # helper class to keep the factory machine logic in one place
  class FactoryMachine
    attr_reader :final_state, :buttons, :whatever

    def initialize(string_input)
      initialize_parts(string_input)
    end

    # Just tryna bruteforce my way for now
    def solve_for_shortest
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

    private

    # generate solutions from ideal button
    def new_solutions(ideal_button, previous_solution = {})
      possible_buttons = (buttons - (previous_solution[:buttons_pressed] || [])).select { (_1 & ideal_button).any? }
      possible_buttons.map do |button|
        solution = {
          state: (previous_solution[:state] || Array.new(final_state.size) { false })
                   .map.with_index { button.include?(_2) ? !_1 : _1 }, # apply button
          buttons_pressed: (previous_solution[:buttons_pressed] || []) + [button]
        }
        solution[:ideal_button] = compute_ideal_button(solution[:state])
        solution
      end
    end

    # The ideal button contain the indices of all positions where ethe state and ideal_state are different
    def compute_ideal_button(state)
      state.zip(final_state).map.with_index { _2 if _1.uniq.count == 2 }.compact
    end

    def initialize_parts(raw_input)
      # split the input into 3 parts
      raw_final_state, raw_buttons, raw_whatever = /(\[.*\]) (.*) ({.*})/.match(raw_input).to_a[1..]
      # treat first part: [..#..#..#...] to turn it into [false, false true ....]
      @final_state = raw_final_state[1..-2].split("").map { { "." => false, "#" => true }[_1] }
      # treat second part: (1) (2,3) (5,3,4) to turn it into [[1], [2, 3], [5, 3, 4]]
      @buttons = raw_buttons.split.map { _1[1..-2].split(",").map(&:to_i).sort }
      # treat last part.
      @whatever = raw_whatever[1..-2].split(",").map(&:to_i)
    end
  end
end

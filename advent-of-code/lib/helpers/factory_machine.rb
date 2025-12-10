module Helpers
  # helper class to keep the factory machine logic in one place
  class FactoryMachine
    attr_reader :final_state, :buttons, :whatever
    def initialize(string_input)
      initialize_parts(string_input)
    end

    # Just tryna bruteforce my way for now
    def solve_for_shortest
      (1..buttons.size).each do |combination_size|
        buttons.combination(combination_size) do |combination|
          current_state = Array.new(final_state.size) { false }
          combination.flatten.uniq.each do |position| # already 3 each deep, god help us all
            current_state[position]  = !current_state[position]
          end
          return combination_size if current_state == final_state
        end
      end
    end

    private

    def initialize_parts(raw_input)
      # split the input into 3 parts
      raw_final_state, raw_buttons, raw_whatever = /(\[.*\]) (.*) ({.*})/.match(raw_input).to_a[1..]
      # treat first part: [..#..#..#...] to turn it into [false, false true ....]
      @final_state = raw_final_state[1..-2].split('').map { {'.' => false, '#' => true}[_1] }
      # treat second part: (1) (2,3) (5,3,4) to turn it into [[1], [2, 3], [5, 3, 4]]
      @buttons = raw_buttons.split.map { _1[1..-2].split(',').map(&:to_i)}
      # treat last part. 
      @whatever = raw_whatever[1..-2].split(',').map(&:to_i)
    end

  end
end
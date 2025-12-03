# frozen_string_literal: true

module Helpers
  # Model of a bank of jolter
  # contains a bunch of helper methods to
  # work the algorigthm step by step
  class JolterBank
    attr_accessor :input_bank, :output_size

    def initialize(input_bank, output_size)
      @input_bank = input_bank
      @output_size = output_size
    end

    # We start by putting the first two numbers of the input bank into the ouput one
    def initialize_ouput
      @output_bank = input_bank.shift(output_size)
    end

    # The steps two advance are as follow:
    # add the first number of the input into the output
    # resolve the ouput to keep the higest number
    def advance
      @output_bank += input_bank.shift(1)
      resolve_output
    end

    # Determines if the input bank still contains jolters
    def empty?
      input_bank.empty?
    end

    # Turn the ouput bank into an integer by concatenating numbers
    # Bunch of casting basically
    def integer_output
      @output_bank.map(&:to_s).join.to_i
    end

    attr_reader :output_bank

    private

    # To resolve the output, we compare each number to the next in the list
    # if a number is smaller than its next neighbour, we nuke it
    # if they're all in descending order or equal, we remove the last one
    def resolve_output
      index_to_delete = 0
      until index_to_delete >= @output_bank.size - 1
        if @output_bank[index_to_delete] < @output_bank[index_to_delete + 1]
          @output_bank.delete_at(index_to_delete)
          return
        end
        index_to_delete += 1
      end
      @output_bank.pop
    end
  end
end

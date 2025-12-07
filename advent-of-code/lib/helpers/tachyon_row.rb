module Helpers
  class TachyonRow
    attr_reader :row

    def initialize(input:)
      @row = input
    end

    def display
      puts row.join(' ')
    end
  end
end
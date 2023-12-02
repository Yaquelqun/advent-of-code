# frozen_string_literal: true

# require each solver 1 by 1 as the days go by
Dir["./lib/solvers/*.rb"].each { |file| require file }
Dir["./lib/helpers/*.rb"].each { |file| require file }
# require_relative "../solvers/"

module AdventOfCode2023
  # contains all solvers classes and define methods to access them
  class SolversDictionary
    SOLVER_CLASSES = {
      1 => ::Solvers::CalibrationParser,
      2 => ::Solvers::CubeCounter
    }.freeze

    MAX_DAYS = SOLVER_CLASSES.count

    private_constant :SOLVER_CLASSES

    MAX_DAYS.times do |day|
      define_method("solve_day_#{day.next}") { SOLVER_CLASSES[day.next].new.solve }
    end

    def method_missing(*_)
      puts "Unsupported day"
    end

    def respond_to_missing?(method, *)
      method =~ /solve_day_(\d+)/ || super
    end
  end
end

# frozen_string_literal: true

# require each solver 1 by 1 as the days go by
require_relative '../solvers/sonar_sweep'
require_relative '../solvers/direction_interpreter'
require_relative '../solvers/diagnostic_reader'

module AdventOfCode2021
  # contains all solvers classes and define methods to access them
  class SolversDictionary
    SOLVER_CLASSES = {
      1 => AdventOfCode2021::Solvers::SonarSweep,
      2 => AdventOfCode2021::Solvers::DirectionInterpreter,
      3 => AdventOfCode2021::Solvers::DiagnosticReader
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

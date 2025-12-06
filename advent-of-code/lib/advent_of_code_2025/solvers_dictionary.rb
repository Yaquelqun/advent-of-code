# frozen_string_literal: true

Dir["./lib/solvers/*.rb"].each { |file| require file }
Dir["./lib/helpers/*.rb"].each { |file| require file }

module AdventOfCode2025
  # contains all solvers classes and define methods to access them
  class SolversDictionary
    SOLVER_CLASSES = {
      1 => ::Solvers::SafePasswordDecryptor,
      2 => ::Solvers::FalseIdsFinder,
      3 => ::Solvers::JolterComputer,
      4 => ::Solvers::ForkliftOptimizer,
      5 => ::Solvers::SpoiledIngredientsIdentifier,
      6 => ::Solvers::CephalopodMathSolver
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

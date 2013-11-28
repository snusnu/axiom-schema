# encoding: utf-8

module Axiom

  # Holds a schema of axiom relations spanning +n+ databases
  class Schema

    include Concord.new(:relations)

    def [](name)
      relations[name]
    end

  end # Schema
end # Axiom

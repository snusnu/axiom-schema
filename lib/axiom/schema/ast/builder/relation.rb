# encoding: utf-8

module Axiom
  class Schema
    module AST
      class Builder

        # Mutable DSL object to help with building an axiom base relation
        class Relation < self
          TYPE = :relation
        end # Relation

      end # Builder
    end # AST
  end # Schema
end # Axiom

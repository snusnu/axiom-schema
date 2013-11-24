# encoding: utf-8

module Axiom
  class Schema
    module AST
      class Builder

        # Mutable AST::Node builder for virtual axiom relations
        class Relation < self
          TYPE = :relation
        end # Relation

      end # Builder
    end # AST
  end # Schema
end # Axiom

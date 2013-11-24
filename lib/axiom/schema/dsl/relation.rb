# encoding: utf-8

module Axiom
  class Schema
    class DSL

      # DSL object to support building {Axiom::Relation} nodes
      class Relation < self

        BUILDER = AST::Builder::Relation

      end # Relation

    end # Definition
  end # Schema
end # Axiom

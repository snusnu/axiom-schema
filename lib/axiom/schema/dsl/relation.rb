# encoding: utf-8

module Axiom
  class Schema
    class DSL

      # Mutable DSL object to help with building a virtual axiom relation
      #
      # @private
      class Relation < self

        BUILDER = AST::Builder::Relation

      end # Relation

    end # Definition
  end # Schema
end # Axiom

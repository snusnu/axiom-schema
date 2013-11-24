# encoding: utf-8

module Axiom
  class Schema
    class DSL

      # DSL object to support building {Axiom::Schema} nodes
      #
      # Serves as the entry point for AST generation
      #
      # @see AST::Builder::Schema
      #
      class Schema < self

        BUILDER = AST::Builder::Schema

        def database(name, uri)
          builder.add_database(name, uri)
        end

        def base_relation(name, &block)
          builder.add_base_relation(Relation::Base.call(name, &block))
        end

        def relation(name, &block)
          builder.add_relation(Relation.call(name, &block))
        end

      end # Schema
    end # DSL
  end # Schema
end # Axiom

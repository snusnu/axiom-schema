# encoding: utf-8

module Axiom
  class Schema
    module AST
      class Builder

        # Mutable AST::Node builder for axiom schema instances
        class Schema < self

          TYPE     = :schema
          CHILDREN = [:databases, :relations].freeze

          children(*CHILDREN)

          def add_database(name, uri)
            add(:databases, :database, name, uri)
          end

          def add_base_relation(node)
            add_node(:relations, :base_relation, node)
          end

          def add_relation(node)
            add_node(:relations, :relation, node)
          end

        end # Schema
      end # Builder
    end # AST
  end # Schema
end # Axiom

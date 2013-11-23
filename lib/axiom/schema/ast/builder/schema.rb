# encoding: utf-8

module Axiom
  class Schema
    module AST
      class Builder

        # Mutable DSL object to help with building an axiom base relation
        class Schema < self

          TYPE     = :schema
          CHILDREN = [:databases, :relations].freeze

          children(*CHILDREN)

          def add_database(name, uri)
            update([databases << s(:database, name, uri)] << relations)
          end

          def add_base_relation(node)
            update([databases] << (relations << node))
          end

          def add_relation(node)
            update([databases] << (relations << node))
          end

        end # Schema
      end # Builder
    end # AST
  end # Schema
end # Axiom

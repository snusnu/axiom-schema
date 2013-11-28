# encoding: utf-8

module Axiom
  class Schema
    module AST
      class Builder
        class Relation < self

          # Mutable AST::Node builder for base relations
          class Base < Builder

            TYPE = :base_relation

            CHILDREN = [
              :attributes,
              :key_constraints,
              :fk_constraints,
              :pk_constraint,
              :database,
              :aliases,
              :name,
            ].freeze

            children(*CHILDREN)

            def self.new(name, ast = root)
              super(ast).with_name(name)
            end

            def add_attribute(*args)
              add(:attributes, :attribute, *args)
            end

            def add_key_constraint(header)
              add(:key_constraints, :key_constraint, *header)
            end

            def add_fk_constraint(references)
              add(:fk_constraints, :fk_constraint, *fk_references(references))
            end

            def with_pk_constraint(header)
              update(:pk_constraint, *header)
            end

            def with_database(name)
              update(:database, name)
            end

            def with_aliases(new_aliases)
              update(:aliases, new_aliases)
            end

            def with_name(new_name)
              update(:name, new_name)
            end

            def has_pk_constraint?
              pk_constraint.children.any?
            end

            private

            def fk_references(references)
              references.map { |name, path| s(:reference, name, *path) }
            end

          end # Base
        end # Relation
      end # Builder
    end # AST
  end # Schema
end # Axiom

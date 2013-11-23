# encoding: utf-8

module Axiom
  class Schema
    module AST
      class Builder
        class Relation < self

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
              update([attributes << s(:attribute, *args)] + children.drop(1))
            end

            def add_key_constraint(header)
              update((children.take(1) << (key_constraints << s(:key_constraint, *header))) + children.drop(2))
            end

            def add_fk_constraint(header)
              update((children.take(2) << (fk_constraints << s(:fk_constraint, *header))) + children.drop(3))
              update((children.take(2) << (fk_constraints << s(:fk_constraint, *header))) + children.drop(3))
            end

            def with_database(name)
              update((children.take(4) << new_node(:database, name)) + children.drop(5))
            end

            def with_pk_constraint(header)
              update((children.take(3) << new_node(:pk_constraint, *header)) + children.drop(4))
            end

            def with_aliases(new_aliases)
              update(children.take(5) << new_node(:aliases, new_aliases) << name)
            end

            def with_name(new_name)
              update(children.take(6) << new_node(:name, new_name))
            end

            private

            def new_node(name, *args)
              send(name).updated(nil, Array(args))
            end

          end # Base
        end # Relation
      end # Builder
    end # AST
  end # Schema
end # Axiom

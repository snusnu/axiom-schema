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
              update([attributes << s(:attribute, *args)] + children[1..-1])
            end

            def add_key_constraint(header)
              update([attributes, key_constraints << s(:key_constraint, *header)] + children[2..-1])
            end

            def add_fk_constraint(header)
              update([attributes, key_constraints, fk_constraints << s(:fk_constraint, *header)] + children[3..-1])
            end

            def with_database(name)
              update((children[0..3] << database.updated(nil, [name])) + children[5..-1])
            end

            def with_pk_constraint(header)
              update((children[0..2] << pk_constraint.updated(nil, header)) + children[4..-1])
            end

            def with_aliases(new_aliases)
              update(children[0..4] << aliases.updated(nil, [new_aliases]) << name)
            end

            def with_name(new_name)
              update(children[0..-2] << name.updated(nil, [new_name]))
            end

          end # Base
        end # Relation
      end # Builder
    end # AST
  end # Schema
end # Axiom

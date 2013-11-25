# encoding: utf-8

module Axiom
  class Schema
    class DSL
      class Relation < self

        class Attribute < BasicObject

          class Name
            def initialize(path)
              @path = path.dup
            end

            def to_a
              @path
            end
          end

          def initialize(relation_name)
            @relation_name = relation_name
          end

          private

          def method_missing(attribute_name)
            Name.new([@relation_name, attribute_name])
          end
        end # Attribute

      end # Relation
    end # DSL
  end # Schema
end # Axiom

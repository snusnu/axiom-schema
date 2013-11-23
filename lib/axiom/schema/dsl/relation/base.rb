# encoding: utf-8

module Axiom
  class Schema
    class DSL
      class Relation < self

        # Mutable DSL object to help with building an axiom base relation
        class Base < DSL

          extend Named

          BUILDER = AST::Builder::Relation::Base

          DEFAULT_KEY_OPTIONS = { primary: false }.freeze

          def self.extract_options(args)
            args = args.dup # don't mutate the outside world
            opts = args.last.is_a?(Hash) ? args.pop : DEFAULT_KEY_OPTIONS
            [ args, opts ]
          end

          def database(name)
            builder.with_database(name)
          end

          def attribute(name, type, options = EMPTY_HASH)
            builder.add_attribute(name, type, options)
          end

          def key(*args)
            header, options = self.class.extract_options(args)
            if options.fetch(:primary)
              builder.with_pk_constraint(header)
            else
              builder.add_key_constraint(header)
            end
          end

          def foreign_key(header)
            builder.add_fk_constraint(header)
          end

          def rename(aliases)
            builder.with_aliases(aliases)
          end

        end # Base
      end # Relation
    end # DSL
  end # Schema
end # Axiom

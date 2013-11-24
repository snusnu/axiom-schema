# encoding: utf-8

module Axiom
  class Schema
    class DSL
      class Relation < self

        # DSL object to support building {Axiom::Relation::Base} nodes
        class Base < DSL

          extend Named

          BUILDER = AST::Builder::Relation::Base

          DEFAULT_KEY_OPTIONS = { primary: false }.freeze

          DUPLICATE_PK_MSG = '%s is already defined'.freeze

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
              assert_singular_pk_constraint
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

          private

          def assert_singular_pk_constraint
            if builder.has_pk_constraint?
              pk = builder.pk_constraint.to_sexp
              fail DuplicatePrimaryKey, DUPLICATE_PK_MSG % pk
            end
          end

        end # Base
      end # Relation
    end # DSL
  end # Schema
end # Axiom

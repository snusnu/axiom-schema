# encoding: utf-8

module Axiom
  class Schema
    class DSL

      include AbstractType
      include Concord.new(:builder)
      include Adamantium::Flat

      def self.new(builder = self::BUILDER.new)
        super
      end

      module Named

        def call(name, &block)
          new(name).instance_eval(&block).to_ast
        end

        def new(name, builder = self::BUILDER.new(name))
          super(builder)
        end

      end # Named

      def to_ast
        builder.to_ast
      end

    end # DSL
  end # Schema
end # Axiom

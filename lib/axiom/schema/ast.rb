# encoding: utf-8

module Axiom
  class Schema
    module AST

      include Concord.new(:ast)

      def to_ast
        ast
      end

    end # AST
  end # Schema
end # Axiom

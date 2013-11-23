# encoding: utf-8

module Axiom
  class Schema
    module AST
      class Builder

        include ::AST::Sexp
        extend  ::AST::Sexp

        include AST

        def self.new(ast = root)
          super(ast)
        end

        def self.root
          s(self::TYPE, *self::CHILDREN.map(&method(:s)))
        end

        # Create name helpers
        #
        # @return [undefined]
        #
        # @api private
        #
        def self.children(*names)
          names.each_with_index do |name, index|
            define_named_child(name, index)
          end
        end
        private_class_method :children

        # Define named child
        #
        # @param [Symbol] name
        # @param [Fixnum] index
        #
        # @return [undefined]
        #
        # @api private
        #
        def self.define_named_child(name, index)
          define_method("#{name}") do
            children.at(index)
          end
        end
        private_class_method :define_named_child

        private

        def children
          ast.children
        end

        def update(new_children)
          @ast = @ast.updated(nil, new_children)
          self
        end

      end # Builder
    end # AST
  end # Schema
end # Axiom

# encoding: utf-8

module Axiom
  class Schema
    module AST

      # Base class for mutable AST::Node builders
      #
      # @abstract
      class Builder

        include AbstractType
        include Memoizable

        include ::AST::Sexp
        extend  ::AST::Sexp

        include Concord.new(:ast)

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

        def to_ast
          ast
        end

        private

        def children
          ast.children
        end

        def update(name, *args)
          idx = index(name)
          update_child(name, idx, new_node(name, *args))
        end

        def add(parent, name, *args)
          add_node(parent, name, s(name, *args))
        end

        def add_node(parent, name, node)
          idx = index(parent)
          update_child(name, idx, children.at(idx) << node)
        end

        def index(name)
          child_names.index(name)
        end

        def head(idx)
          children.take(idx)
        end

        def tail(idx)
          children.drop(idx.succ)
        end

        def child_names
          self.class::CHILDREN
        end
        memoize :child_names

        def new_node(name, *args)
          send(name).updated(nil, args)
        end

        def update_child(name, idx, node)
          update_node(head(idx).push(node, *tail(idx)))
        end

        def update_node(new_children)
          @ast = @ast.updated(nil, new_children)
          self
        end

      end # Builder
    end # AST
  end # Schema
end # Axiom

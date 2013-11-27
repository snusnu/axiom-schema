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

        def update_terminal(name, *args)
          idx, last = index(name), last_index
          if idx == 0
            update([new_node(name, *args)] + children.drop(1))
          elsif idx < last
            update((children.take(idx) << new_node(name, *args)) + children.drop(idx + 1))
          elsif idx == last
            update(children.take(idx) << new_node(name, *args))
          end
        end

        def add_terminal(parent, name, *args)
          idx, last = index(parent), last_index
          if idx == 0
            update([children.at(idx) << s(name, *args)] + children.drop(1))
          elsif idx < last
            update((children.take(idx) << (children.at(idx) << s(name, *args))) + children.drop(idx + 1))
          elsif idx == last
            update(children.take(idx) << s(name, *args))
          end
        end

        def index(name)
          child_names.index(name)
        end

        def last_index
          child_names.size - 1
        end
        memoize :last_index

        def child_names
          self.class::CHILDREN
        end
        memoize :child_names

        def new_node(name, *args)
          send(name).updated(nil, args)
        end

        def update(new_children)
          @ast = @ast.updated(nil, new_children)
          self
        end

      end # Builder
    end # AST
  end # Schema
end # Axiom

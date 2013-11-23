# encoding: utf-8

module Axiom
  class Schema

    # A database with a given +name+ and +adapter+
    #
    # @api private
    class Database
      include Concord.new(:name, :adapter)

      # Build a database with a given +name+ and +uri+
      #
      # @param [Symbol] name
      #   the database's name
      #
      # @param [Addressable::URI] uri
      #   the uri for initializing the adapter
      #
      # @return [Database]
      #
      # @api private
      def self.build(name, uri)
        new(name, Axiom::Adapter.build(uri))
      end

    end # Database
  end # Schema
end # Axiom

# encoding: utf-8

require 'axiom'
require 'axiom-optimizer'
require 'ast'
require 'concord'
require 'abstract_type'
require 'adamantium'

module Axiom
  class Schema

    # Raised when trying to establish more than one
    # primary key constraint for a base relation
    DuplicatePrimaryKey = Class.new(StandardError)

  end # Schema
end # Axiom

require 'axiom/schema'
require 'axiom/schema/version'
require 'axiom/schema/ast/builder'
require 'axiom/schema/ast/builder/relation/base'
require 'axiom/schema/ast/builder/relation'
require 'axiom/schema/ast/builder/schema'
require 'axiom/schema/dsl'
require 'axiom/schema/dsl/relation/attribute'
require 'axiom/schema/dsl/relation/base'
require 'axiom/schema/dsl/relation'
require 'axiom/schema/dsl/schema'

# encoding: utf-8

require 'spec_helper'

describe Schema::DSL::Relation::Base, '#attribute' do
  subject { object.attribute(name, type, options) }

  let(:object)        { described_class.new(relation_name) }
  let(:relation_name) { :test }
  let(:name)          { :id }
  let(:type)          { Integer }
  let(:options)       { Hash.new }

  let(:expected) {
    s(:base_relation,
      s(:attributes,
        s(:attribute, name, type, options)),
      s(:key_constraints),
      s(:fk_constraints),
      s(:pk_constraint),
      s(:database),
      s(:aliases),
      s(:name, relation_name))
  }

  it_behaves_like 'an ast node builder'
end

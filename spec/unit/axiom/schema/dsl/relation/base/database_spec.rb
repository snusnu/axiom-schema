# encoding: utf-8

require 'spec_helper'

describe Schema::DSL::Relation::Base, '#database' do
  subject { object.database(database) }

  let(:object)   { described_class.new(name) }
  let(:name)     { :test }
  let(:database) { :memory }

  let(:expected) {
    s(:base_relation,
      s(:attributes),
      s(:key_constraints),
      s(:fk_constraints),
      s(:pk_constraint),
      s(:database, database),
      s(:aliases),
      s(:name, name))
  }

  it_behaves_like 'an ast node builder'
end

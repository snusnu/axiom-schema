# encoding: utf-8

require 'spec_helper'

describe Schema::DSL::Relation::Base, '#foreign_key' do
  subject { object.foreign_key(references) }

  let(:object)        { described_class.new(relation_name) }
  let(:relation_name) { :test }
  let(:references)    { Hash[name => [relation, attribute]] }

  let(:name)      { :person_id }
  let(:relation)  { :people }
  let(:attribute) { :id }

  let(:expected) {
    s(:base_relation,
      s(:attributes),
      s(:key_constraints),
      s(:fk_constraints,
        s(:fk_constraint,
          s(:reference, name, relation, attribute))),
      s(:pk_constraint),
      s(:database),
      s(:aliases),
      s(:name, relation_name))
  }

  it_behaves_like 'an ast node builder'
end

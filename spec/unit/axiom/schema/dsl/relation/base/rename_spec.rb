# encoding: utf-8

require 'spec_helper'

describe Schema::DSL::Relation::Base, '#rename' do
  subject { object.rename(aliases) }

  let(:object)  { described_class.new(name) }
  let(:name)    { :test }
  let(:aliases) { Hash[a: :b] }

  let(:expected) {
    s(:base_relation,
      s(:attributes),
      s(:key_constraints),
      s(:fk_constraints),
      s(:pk_constraint),
      s(:database),
      s(:aliases, aliases),
      s(:name, name))
  }

  it_behaves_like 'an ast node builder'
end

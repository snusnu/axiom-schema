# encoding: utf-8

require 'spec_helper'

describe Schema::DSL::Schema, '#base_relation' do
  subject do
    object.base_relation(name) do
      database :memory
      attribute :id, Integer
      key :id, primary: true
    end
  end

  let(:object) { described_class.new }
  let(:name)   { :test }

  let(:expected) {
    s(:schema,
      s(:databases),
      s(:relations,
        s(:base_relation,
          s(:attributes,
            s(:attribute, :id, Integer, {})),
          s(:key_constraints),
          s(:fk_constraints),
          s(:pk_constraint, :id),
          s(:database, :memory),
          s(:aliases),
          s(:name, name))))
  }

  it_behaves_like 'an ast node builder'
end

# encoding: utf-8

require 'spec_helper'

describe Schema::DSL::Relation::Base, '#key' do
  let(:object) { described_class.new(name) }
  let(:name)   { :test }

  context 'when a pk constraint is established' do

    let(:expected) {
      s(:base_relation,
        s(:attributes),
        s(:key_constraints),
        s(:fk_constraints),
        pk_constraint,
        s(:database),
        s(:aliases),
        s(:name, name))
    }

    context 'with a single attribute key' do
      subject { object.key(:id, primary: true) }

      let(:pk_constraint) { s(:pk_constraint, :id) }

      it_behaves_like 'an ast node builder'
    end

    context 'with a composite key' do
      subject { object.key(:id, :email, primary: true) }

      let(:pk_constraint) { s(:pk_constraint, :id, :email) }

      it_behaves_like 'an ast node builder'
    end

    context 'and another pk constraint has already been defined' do
      subject { object.key(:id, primary: true) }
      before  { object.key(:id, primary: true) }

      it 'raises DuplicatePrimaryKey' do
        error = Axiom::Schema::DuplicatePrimaryKey
        msg   = '(pk-constraint :id) is already defined'
        expect { subject }.to raise_error(error, msg)
      end
    end

  end

  context 'when a unique constraint is established' do

    let(:expected) {
      s(:base_relation,
        s(:attributes),
        s(:key_constraints, key_constraint),
        s(:fk_constraints),
        s(:pk_constraint),
        s(:database),
        s(:aliases),
        s(:name, name))
    }

    context 'with a single attribute key' do
      subject { object.key(:id) }

      let(:key_constraint) { s(:key_constraint, :id) }

      it_behaves_like 'an ast node builder'
    end

    context 'with a composite key' do
      subject { object.key(:id, :email) }
      let(:key_constraint) { s(:key_constraint, :id, :email) }

      it_behaves_like 'an ast node builder'
    end
  end
end

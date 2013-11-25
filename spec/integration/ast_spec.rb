# encoding: utf-8

require 'spec_helper'

describe Axiom::Schema::DSL::Schema, '.build' do

  subject do

    Axiom::Schema::DSL::Schema.build do
      database(:memory, ':memory://test')

      base_relation(:people) do
        database :memory

        attribute :id,    Integer
        attribute :email, String
        attribute :name,  String

        key :id, primary: true
        key :email
      end

      base_relation(:addresses) do
        database :memory

        attribute :id,        Integer
        attribute :person_id, Integer
        attribute :city,      String
        attribute :zip,       String

        key :id, primary: true

        foreign_key person_id: [:people, :id]

        rename zip: :zipcode

      end
    end
  end

  let(:expected) do

    s(:schema,
      s(:databases,
        s(:database, :memory, ':memory://test')),
      s(:relations,
        s(:base_relation,
          s(:attributes,
            s(:attribute, :id, Integer, {}),
            s(:attribute, :email, String, {}),
            s(:attribute, :name, String, {})),
          s(:key_constraints,
            s(:key_constraint, :email)),
          s(:fk_constraints),
          s(:pk_constraint, :id),
          s(:database, :memory),
          s(:aliases),
          s(:name, :people)),
        s(:base_relation,
          s(:attributes,
            s(:attribute, :id, Integer, {}),
            s(:attribute, :person_id, Integer, {}),
            s(:attribute, :city, String, {}),
            s(:attribute, :zip, String, {})),
          s(:key_constraints),
          s(:fk_constraints,
            s(:fk_constraint,
              s(:reference, :person_id, :people, :id))),
          s(:pk_constraint, :id),
          s(:database, :memory),
          s(:aliases, {zip: :zipcode}),
          s(:name, :addresses))))
  end

  it_behaves_like 'an ast node builder'
end

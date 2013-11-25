# encoding: utf-8

require 'spec_helper'

describe 'Defining a schema of axiom relations' do

  let(:schema) do

    definition = Axiom::Schema::DSL::Schema.new do

      database(:memory, ':memory://test')

      base_relation(:people) do
        repository :memory

        attribute :id,    Integer
        attribute :email, String
        attribute :name,  String

        key :id, primary: true
        key :email
      end

      base_relation(:addresses) do
        repository :memory

        attribute :id,        Integer
        attribute :person_id, Integer
        attribute :city,      String
        attribute :zip,       String

        rename zip: :zipcode

        key :id, primary: true
        foreign_key person_id: people.id
      end

      base_relation(:tasks) do
        repository :memory

        attribute :id,        Integer
        attribute :person_id, Integer
        attribute :name,      String

        key :id, primary: true
        foreign_key person_id: people.id
      end

      relation(:people_with_tasks) do
        people.join(
          tasks.rename(id: :task_id, person_id: :id, name: :task_name)
        ).group(:tasks, [:task_id, :task_name])
      end
    end

    Axiom::Schema.new(definition.to_ast)

  end

  let(:people) {
    Axiom::Relation::Base.new(:people, people_header, EMPTY_ARRAY)
  }

  let(:people_header) {
    Axiom::Relation::Header.coerce(
      [
        [:id,    Integer],
        [:email, String],
        [:name,  String]
      ],
      :keys => [:id]
    )
  }

  it 'allows to retrieve registered relations' do
    pending 'not yet implemented' do
      expect(schema[:people]).to eql(people)
    end
  end

end

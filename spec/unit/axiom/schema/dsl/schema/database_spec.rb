# encoding: utf-8

require 'spec_helper'

describe Schema::DSL::Schema, '#database' do
  subject { object.database(name, uri) }

  let(:object) { described_class.new }
  let(:name)   { :memory }
  let(:uri)    { ':memory://test' }

  let(:expected) {
    s(:schema,
      s(:databases,
        s(:database, name, uri)),
      s(:relations))
  }

  it_behaves_like 'an ast node builder'
end

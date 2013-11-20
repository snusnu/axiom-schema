# encoding: utf-8

require 'spec_helper'

describe Axiom::Schema::VERSION do
  it 'exists' do
    expect(Axiom::Schema::VERSION).to be_a(String)
    expect(Axiom::Schema::VERSION).to be_frozen
  end
end

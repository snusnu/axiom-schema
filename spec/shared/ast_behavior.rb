# encoding: utf-8

shared_examples_for 'an ast node builder' do
  it 'builds a proper ast' do
    expect(subject.to_ast).to eq(expected)
  end
end

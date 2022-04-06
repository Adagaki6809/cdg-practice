# frozen_string_literal: true

require 'rspec'
require './task1'

RSpec.describe 'Task1' do
  it 'returns 2 to the power (of the length of the entered word) if word ends with CS' do
    expect(print_something('helloCS')).to eq(128)
  end

  it 'returns the entered word backwards if word doesnt end with CS' do
    expect(print_something('hello')).to eq('olleh')
  end

  it 'returns the entered word backwards if word doesnt end with CS' do
    expect(print_something('123cs')).to eq('sc321')
  end
end

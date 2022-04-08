# frozen_string_literal: true

require 'rspec'
require './task2'

RSpec.describe 'Task2' do
  it 'returns empty array if user needs 0 pokemons' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('', '')
    expect(get_pokemons(0)).to eq([])
  end

  it 'returns array of 1 pokemon if user needs 1 pokemon' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('pikachu', 'yellow')
    expect(get_pokemons(1)).to eq([{ name: 'pikachu', color: 'yellow' }])
  end

  it 'returns array of 2 pokemons if user needs 2 pokemons' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('pikachu', 'yellow', 'charmander', 'orange')
    expect(get_pokemons(2)).to eq([{ name: 'pikachu', color: 'yellow' },
                                   { name: 'charmander', color: 'orange' }])
  end
end

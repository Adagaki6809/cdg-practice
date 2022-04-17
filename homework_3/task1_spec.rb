# frozen_string_literal: true

require 'rspec'
require './task1'

RSpec.describe 'index' do
  let(:string) do
    <<~STRING
      Hello
      World
      Goodbye
      Universe
    STRING
  end

  before { File.write(ROUTE_PATH, string) }

  it 'prints all lines from file' do
    expect { index }.to output(string).to_stdout
  end
end

RSpec.describe 'find' do
  let(:string) do
    <<~STRING
      Hello
      World
      Goodbye
      Universe
    STRING
  end

  before { File.write(ROUTE_PATH, string) }

  it 'prints 1st line from file' do
    expect { find(0) }.to output("Hello\n").to_stdout
  end

  it 'prints 3rd line from file' do
    expect { find(2) }.to output("Goodbye\n").to_stdout
  end
end

RSpec.describe 'where' do
  let(:string) do
    <<~STRING
      Hello
      World
      Goodbye
      Universe
    STRING
  end

  before { File.write(ROUTE_PATH, string) }

  it 'prints indexes of lines and lines itself if line includes Good' do
    expect { where('Good') }.to output("[2]\n[\"Goodbye\"]\n").to_stdout
  end
end

RSpec.describe 'update' do
  let(:string) do
    <<~STRING
      Hello
      World
      Goodbye
      Universe
    STRING
  end

  before { File.write(ROUTE_PATH, string) }

  it 'updates 4th line to Cosmos' do
    buffer = StringIO.new
    content = "Hello\nWorld\nGoodbye\nCosmos\n"
    allow(File).to receive(:write).with(ROUTE_PATH, content).and_yield(buffer)
    update(3, 'Cosmos')
    expect(buffer.string).to eq(content)
  end
end

RSpec.describe 'delete' do
  let(:string) do
    <<~STRING
      Hello
      World
      Goodbye
      Universe
    STRING
  end

  before { File.write(ROUTE_PATH, string) }

  it 'deletes 2nd line from file' do
    buffer = StringIO.new
    content = "Hello\nGoodbye\nUniverse\n"
    allow(File).to receive(:write).with(ROUTE_PATH, content).and_yield(buffer)
    delete(1)
    expect(buffer.string).to eq(content)
  end

  it 'deletes 3nd line from file' do
    buffer = StringIO.new
    content = "Hello\nWorld\nUniverse\n"
    allow(File).to receive(:write).with(ROUTE_PATH, content).and_yield(buffer)
    delete(2)
    expect(buffer.string).to eq(content)
  end
end

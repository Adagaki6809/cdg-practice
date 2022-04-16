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

  it 'it prints all lines with 4th line updated to Cosmos' do
    expect { update(3, 'Cosmos') }.to output("Hello\nWorld\nGoodbye\nCosmos\n").to_stdout
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

  it 'deletes 2nd line from file and prints all lines' do
    expect { delete(1) }.to output("Hello\nGoodbye\nUniverse\n").to_stdout
  end

  it 'deletes 3nd line from file and prints all lines' do
    expect { delete(2) }.to output("Hello\nWorld\nUniverse\n").to_stdout
  end
end

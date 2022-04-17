# frozen_string_literal: true

require 'rspec'
require './task2'

RSpec.describe 'students' do
  it 'closes the program' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return("-1\n")
    expect { students }.to output('Введите возраст: ').to_stdout
  end

  it 'prints students who are 17 years old' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return("17\n", "-1\n")
    expect { students }.to output("#{'Введите возраст: ' * 2}Никита Никитин 17\nСтепан Степанов 17\n").to_stdout
  end

  it 'prints students who are 19 and 21 years old' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return("19\n", "21\n", "-1\n")
    expect { students }.to output("#{'Введите возраст: ' * 3}" \
      "Петр Петров 19\nЕгор Егоров 19\nИван Иванов 21\nСемён Семёнов 21\n").to_stdout
  end

  it 'prints all students' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return("17\n", "18\n", "19\n", "20\n", "21\n")
    expect { students }.to output("#{'Введите возраст: ' * 5}" \
      "Никита Никитин 17\nСтепан Степанов 17\nВасилий Васильев 18\nМихаил Михайлов 18\nПетр Петров 19\n" \
      "Егор Егоров 19\nНиколай Николаев 20\nАлексей Алексеев 20\nИван Иванов 21\nСемён Семёнов 21\n").to_stdout
  end
end

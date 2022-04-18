# frozen_string_literal: true

require 'rspec'
require './task3'

RSpec.describe 'deposit' do
  it 'returns the balance after depositing 200' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return("200.0\n")
    expect(deposit(100.0)).to eq(300.0)
    expect { deposit(100.0) }.to output('Введите сумму для пополнения, например, 100 или 250.42 > ' \
      "Ваш баланс: 300.0\n").to_stdout
  end

  it 'returns same balance if user tries to deposit 0' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return("0\n")
    expect(deposit(100.0)).to eq(100.0)
    expect { deposit(100.0) }.to output('Введите сумму для пополнения, например, 100 или 250.42 > ' \
      "Сумма должна быть больше нуля!\n").to_stdout
  end
end

RSpec.describe 'withdraw' do
  it 'returns balance after withdrawing 30' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return("30\n")
    expect(withdraw(100.0)).to eq(70.0)
    expect { withdraw(100.0) }.to output('Введите сумму для снятия > ' \
      "Ваш баланс: 70.0\n").to_stdout
  end

  it 'returns same balance if user tries to withdraw 0' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return("0\n")
    expect(withdraw(100.0)).to eq(100.0)
    expect { withdraw(100.0) }.to output('Введите сумму для снятия > ' \
      "Сумма должна быть больше нуля!\n").to_stdout
  end

  it 'returns same balance if user tries to withdraw more than what is on the card' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return("100.00001\n")
    expect(withdraw(100.0)).to eq(100.0)
    expect { withdraw(100.0) }.to output('Введите сумму для снятия > ' \
      "Недостаточно денег на счете. Максимально возможная сумма для снятия: 100.0\n").to_stdout
  end
end

RSpec.describe 'balance' do
  it 'prints balance' do
    expect { balance(375.39) }.to output("Ваш баланс: 375.39\n").to_stdout
  end
end

RSpec.describe 'atm' do
  it 'writes balance to the balance.txt after deposit and withdraw when user quites the program' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return("d\n", "200\n", "W\n", "50\n", "q\n")
    buffer = StringIO.new
    allow(File).to receive(:open).with(BALANCE_PATH, 'w').and_yield(buffer)
    atm
    expect(buffer.string).to eq('250.0')
  end

  it 'prints help information when user enters unknown command' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return("dwiuerhiow\n", "q\n")
    expect { atm }.to output('Введите одну из следующих команд: D (deposit), W (withdraw), B (balance) и Q (quit) > ' \
      "Такой команды не существует.\n" \
      'Введите одну из следующих команд: D (deposit), W (withdraw), B (balance) и Q (quit) > ').to_stdout
  end

  context 'file balance.txt does not exist' do
    before { File.delete(BALANCE_PATH) if File.exist?(BALANCE_PATH) }
    it 'takes initial balance from BALANCE constant instead of file balance.txt' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return("b\n", "q\n")
      expect do
        atm
      end.to output('Введите одну из следующих команд: D (deposit), W (withdraw), B (balance) и Q (quit) > ' \
        "Ваш баланс: 100.0\n" \
        'Введите одну из следующих команд: D (deposit), W (withdraw), B (balance) и Q (quit) > ').to_stdout
    end
  end
end

# frozen_string_literal: true

BALANCE = 100.0
BALANCE_PATH = "#{File.dirname(__FILE__)}/balance.txt".freeze

def atm
  balance = File.exist?(BALANCE_PATH) ? File.read(BALANCE_PATH).to_f : BALANCE
  loop do
    print 'Введите одну из следующих команд: D (deposit), W (withdraw), B (balance) и Q (quit) > '
    case gets.chomp.downcase
    when 'd'
      balance = deposit(balance)
    when 'w'
      balance = withdraw(balance)
    when 'b'
      balance(balance)
    when 'q'
      File.open(BALANCE_PATH, 'w') { |f| f.write(balance) }
      break
    else
      puts 'Такой команды не существует.'
    end
  end
end

def deposit(balance)
  print 'Введите сумму для пополнения, например, 100 или 250.42 > '
  sum = gets.to_f
  if sum.positive?
    balance += sum
    balance(balance)
  else
    puts 'Сумма должна быть больше нуля!'
  end
  balance
end

def withdraw(balance)
  print 'Введите сумму для снятия > '
  sum = gets.to_f
  if sum.positive? && sum <= balance
    balance -= sum
    balance(balance)
  elsif sum <= 0
    puts 'Сумма должна быть больше нуля!'
  else
    puts "Недостаточно денег на счете. Максимально возможная сумма для снятия: #{balance}"
  end
  balance
end

def balance(balance)
  puts "Ваш баланс: #{balance}"
end

atm

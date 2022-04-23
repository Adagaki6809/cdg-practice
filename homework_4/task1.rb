# frozen_string_literal: true

# cash machine class
class CashMachine
  BALANCE = 100.0
  BALANCE_PATH = "#{File.dirname(__FILE__)}/balance.txt".freeze

  def initialize
    @balance = File.exist?(BALANCE_PATH) ? File.read(BALANCE_PATH).to_f : BALANCE
  end

  def self.init(machine)
    loop do
      print 'Введите одну из следующих команд: D (deposit), W (withdraw), B (balance) и Q (quit) > '
      case gets.chomp.downcase
      when 'd'
        machine.deposit
      when 'w'
        machine.withdraw
      when 'b'
        machine.balance
      when 'q'
        File.open(BALANCE_PATH, 'w') { |f| f.write(machine.balance) }
        break
      else
        puts 'Такой команды не существует.'
      end
    end
  end

  def deposit
    print 'Введите сумму для пополнения, например, 100 или 250.42 > '
    sum = gets.to_f
    if sum.positive?
      @balance += sum
      balance
    else
      puts 'Сумма должна быть больше нуля!'
    end
  end

  def withdraw
    print 'Введите сумму для снятия > '
    sum = gets.to_f
    if sum.positive? && sum <= @balance
      @balance -= sum
      balance
    elsif sum <= 0
      puts 'Сумма должна быть больше нуля!'
    else
      puts "Недостаточно денег на счете. Максимально возможная сумма для снятия: #{@balance}"
    end
  end

  def balance
    puts "Ваш баланс: #{@balance}"
    @balance
  end
end

machine = CashMachine.new
CashMachine.init(machine)

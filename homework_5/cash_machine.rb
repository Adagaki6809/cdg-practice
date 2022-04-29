# frozen_string_literal: true

require 'socket'
require 'cgi'
require 'uri'

# cash machine
class CashMachine
  BALANCE = 100.0
  BALANCE_PATH = "#{File.dirname(__FILE__)}/balance.txt".freeze

  def initialize
    @balance = File.exist?(BALANCE_PATH) ? File.read(BALANCE_PATH).to_f : BALANCE
  end

  def self.init(machine)
    server = TCPServer.new('0.0.0.0', 3000)
    while (@@connection = server.accept)
      request = @@connection.gets
      method, path = request.split(' ')
      next if method != 'GET'

      uri = URI(path)
      params = CGI.parse(uri.query || '')
      case uri.path
      when '/deposit'
        machine.deposit(params['value'].first.to_f)
      when '/withdraw'
        machine.withdraw(params['value'].first.to_f)
      when '/balance'
        machine.balance
      when '/quit'
        File.write(BALANCE_PATH, machine.balance)
        break
      when '/favicon.ico'
        machine.send_message('No favicon at this server', 404, 'Not Found')
      else
        machine.send_message('Resource not found on this server', 404, 'Not Found')
      end
    end
  end

  def deposit(sum)
    if sum.positive?
      @balance += sum
      balance
    else
      send_message('Сумма должна быть больше нуля!', 400, 'Bad Request')
    end
  end

  def withdraw(sum)
    if sum.positive? && sum <= @balance
      @balance -= sum
      balance
    elsif sum <= 0
      send_message('Сумма должна быть больше нуля!', 400, 'Bad Request')
    else
      send_message(
        "Недостаточно денег на счете. Максимально возможная сумма для снятия: #{@balance}", 400, 'Bad Request'
      )
    end
  end

  def balance
    send_message("Ваш баланс: #{@balance}")
    @balance
  end

  def send_message(message, status_code = 200, status_message = 'OK')
    @@connection.print "HTTP/1.1 #{status_code} #{status_message}\r\n"
    @@connection.print "Content-Type: text/html;charset=utf-8\r\n"
    @@connection.print "\r\n"
    @@connection.print "<H1>#{message}</H1>"
    @@connection.close
  end
end

machine = CashMachine.new
CashMachine.init(machine)

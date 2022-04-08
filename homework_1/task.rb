# frozen_string_literal: true

def greeting(name, surname, age)
  if age < 18
    "Привет, #{name} #{surname}. Тебе меньше 18 лет, но начать учиться программировать никогда не рано."
  else
    "Привет, #{name} #{surname}. Самое время заняться делом!"
  end
end

print 'Введите Ваше имя: '
name = gets.chomp
print 'Введите Вашу фамилию: '
surname = gets.chomp
print 'Введите Ваш возраст: '
age = gets.to_i

puts greeting(name, surname, age)

def foobar(number1, number2)
  if number1 == 20 || number2 == 20 # if [number1, number2].include? 20
    number2
  else
    number1 + number2
  end
end

print 'Введите первое число: '
number1 = gets.to_i
print 'Введите второе число: '
number2 = gets.to_i

puts foobar(number1, number2)

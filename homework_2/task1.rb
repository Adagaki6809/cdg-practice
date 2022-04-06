# frozen_string_literal: true

def print_something(word)
  word.end_with?('CS') ? 2**word.length : word.reverse
end

print 'Введите слово: '
word = gets.chomp
puts print_something(word)

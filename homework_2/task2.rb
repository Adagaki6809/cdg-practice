# frozen_string_literal: true

def get_pokemons(number)
  pokemons = []
  number.times do
    print 'Введите имя: '
    name = gets.chomp
    print 'Введите цвет: '
    color = gets.chomp
    pokemons << { name:, color: }
  end
  pokemons
end

print 'Введите кол-во покемонов: '
number = gets.to_i
print get_pokemons(number)

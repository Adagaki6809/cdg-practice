# frozen_string_literal: true

def get_pokemons(number, names, colors)
  pokemons = []
  number.times do |i|
    pokemons << { name: names[i], color: colors[i] }
  end
  pokemons
end

def get_names_and_colors(number)
  names = []
  colors = []
  number.times do
    print 'Введите имя: '
    names << gets.chomp
    print 'Введите цвет: '
    colors << gets.chomp
  end
  [names, colors]
end

print 'Введите кол-во покемонов: '
number = gets.to_i
names, colors = get_names_and_colors(number)
result = get_pokemons(number, names, colors)
print result

# frozen_string_literal: true

ROUTE_PATH = 'darksouls2.txt'
BUFFER_PATH = 'buffer.txt'

# выводит все строки
def index
  File.foreach(ROUTE_PATH) { |line| puts line }
end

# находит конкретную строку в файле и выводит ее
def find(id)
  File.foreach(ROUTE_PATH).with_index do |line, index|
    if index == id
      puts line
      break
    end
  end
end

# находит все строки, где есть указанный паттерн
def where(pattern)
  matched_lines = {}
  File.foreach(ROUTE_PATH).with_index do |line, index|
    matched_lines[index] = line if line.include?(pattern)
  end
  pp matched_lines.keys
  pp matched_lines.values.map(&:chomp)
end

# обновляет конкретную строку файла
def update(id, text)
  buffer = File.open(BUFFER_PATH, 'w')
  File.foreach(ROUTE_PATH).with_index do |line, index|
    buffer.puts(index == id ? text : line)
  end
  buffer.close

  File.write(ROUTE_PATH, File.read(BUFFER_PATH))
  File.delete(BUFFER_PATH) if File.exist?(BUFFER_PATH)
  index
end

# удаляет строку
def delete(id)
  buffer = File.open(BUFFER_PATH, 'w')
  File.foreach(ROUTE_PATH).with_index do |line, index|
    buffer.puts(line) if index != id
  end
  buffer.close

  File.write(ROUTE_PATH, File.read(BUFFER_PATH))
  File.delete(BUFFER_PATH) if File.exist?(BUFFER_PATH)
  index
end

index
find(2)
where('оскол')
update(5, 'привет мир') # 6. Осколок фляги в колодце
delete(5)

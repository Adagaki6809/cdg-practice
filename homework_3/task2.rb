# frozen_string_literal: true

STUDENTS_PATH = "#{File.dirname(__FILE__)}/students.txt".freeze
RESULTS_PATH = "#{File.dirname(__FILE__)}/results.txt".freeze

def students
  File.write(RESULTS_PATH, '')
  all_students = File.read(STUDENTS_PATH).split("\n")
  result_students = 0
  loop do
    print 'Введите возраст: '
    age = gets.to_i
    break if age == -1

    all_students.each do |student|
      if student.split(' ').last.to_i == age
        File.write(RESULTS_PATH, "#{student}\n", mode: 'a')
        result_students += 1
      end
    end
    break if result_students == all_students.size
  end
  File.foreach(RESULTS_PATH) { |student| puts student }
end

students

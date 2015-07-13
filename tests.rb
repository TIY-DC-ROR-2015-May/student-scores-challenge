require 'minitest/autorun'
require 'csv'
require 'pry'

class Student
  def self.all
    @students = []
    CSV.foreach "db.csv" do |row|
      @students.push(Student.new(row))
    end
    @students.shift
    @students
  end
attr_reader :first_name, :test_average, :id, :quiz_average, :test_average, :absences
  def initialize array
    @id, @first_name, @last_name, @absences, @quiz_average, @test_average = array
  end

  def self.without_absences
    all.select{|s| s.absences=="0"}
  end

  def self.top_by_test_score
    all.max_by{|s| s.test_average}
  end
end

class StudentTest < Minitest::Test
  def test_student_attributes
    s = Student.new([1, "Su", "Kim", 0, 99, 100])
    assert_equal 1, s.id
    assert_equal "Su", s.first_name
    assert_equal 100, s.test_average
  end

  def test_can_find_student_with_best_tests
    assert_equal 14, Student.without_absences.count
  end

  def test_can_find_highest_scoring_student
    assert_equal "Enos", Student.top_by_test_score.first_name
  end
end

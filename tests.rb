require 'minitest/autorun'
require 'csv'
require 'pry'

class Student
  def self.all
    result = []
    CSV.foreach "db.csv" do |row|
      next if row.first == "Student Id"
      s = Student.new row
      result.push s
    end
    result
  end

  def self.without_absences
    all.select { |student| student.absences == 0 }
  end

  def self.top_by_average_score
    all.max_by { |student| student.final_average }
  end

  attr_reader :id, :first_name, :absences

  def initialize attributes
    # @id = attributes.first
    # @first_name = attributes[1]
    # @test_avg = attributes.last
    @id, @first_name, @last_name, absences, quiz, test = attributes

    @absences = Integer(absences)
    @quiz     = Float(quiz)
    @test     = Float(test)
  end

  #%w( test quiz ).each do |word|
  #  define_method "#{word}_average" do
  #    instance_variable_get "@#{word}"
  #  end
  #end
  def test_average
    @test
  end
  def quiz_average
    @quiz
  end

  def final_average
    0.4 * quiz_average + 0.6 * test_average
  end
end

class StudentTest < Minitest::Test
  def test_student_attributes
    s = Student.new([1, "Su", "Kim", 0, 99, 100])
    assert_equal 1, s.id
    assert_equal "Su", s.first_name
    assert_equal 100, s.test_average
  end

  def test_can_find_student_without_absences
    assert_equal 14, Student.without_absences.count
  end

  def test_can_find_highest_scoring_student
    assert_equal "Toni", Student.top_by_average_score.first_name
  end
end

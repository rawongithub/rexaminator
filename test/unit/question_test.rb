require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  context "Question" do

    context "associations" do
      should have_many(:answers).dependent(:destroy)
      should have_many(:exam_questions).dependent(:destroy)
      should have_many(:exams).through(:exam_questions)
      should have_many(:feedbacks).dependent(:destroy)
      should have_and_belong_to_many(:categories)
    end

    context "validations" do
      should validate_presence_of(:body)
    end

    context "attributes mass assignment" do
      should_not allow_mass_assignment_of(:body)
      should_not allow_mass_assignment_of(:active)
      should_not allow_mass_assignment_of(:answers)
      should_not allow_mass_assignment_of(:comment)
      should_not allow_mass_assignment_of(:category_id)
    end

    context "instance" do

      setup do
        @question = question_from_factory
      end

      should "always have 4 answers" do
        @question.answers.pop
        assert_equal 3, @question.answers.size
        assert !@question.valid?
        @question.answers.build(FactoryGirl.attributes_for(:answer))
        assert_equal 4, @question.answers.size
        assert @question.valid?
        @question.answers.build(FactoryGirl.attributes_for(:answer))
        assert_equal 5, @question.answers.size
        assert !@question.valid?
      end

      should "have minimum one answer correct" do
        assert @question.valid?
        @question.answers = []
        4.times { @question.answers.build(FactoryGirl.attributes_for(:answer, :correct => false)) }
        assert !@question.valid?
      end

      should "have answers ordered asc" do
        answers = @question.answers.map(&:id)
        assert answers == answers.sort
      end

      should "be accurate for all correct answers" do
        assert @question.accurate?([true, true, true, true])
        assert !@question.accurate?([true, true, true, false])
      end

      should "have min one category assigned" do
        assert !@question.categories.empty?
        assert @question.valid?
        @question.categories = []
        assert @question.categories.empty?
        assert !@question.valid?
      end

      should "destroy all dependent answers on destroy itself" do
        assert @question.save
        answers_ids = @question.answers.map{|a| a.id}
        assert @question.destroy
        answers_ids.each do |a|
          assert !Answer.exists?(a)
        end
      end

      should "destroy all dependent exam_questions on destroy itself" do
        assert @question.save
        exam_questions_ids = @question.exam_questions.map{|eq| eq.id}
        assert @question.destroy
        exam_questions_ids.each do |eq|
          assert !ExamQuestion.exists?(eq)
        end
      end

    end

  end

end


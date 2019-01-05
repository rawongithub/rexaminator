require 'test_helper'

class ExamTest < ActiveSupport::TestCase

  context "An Exam" do

    context "instance" do

      setup do
        @exam = FactoryGirl.build(:exam)
        @question = question_from_factory
      end

      should have_many(:questions).through(:exam_questions)
      should have_many :exam_questions

      should validate_presence_of :sessionid

      should "act as state machine" do
        for i in 1..20
          @exam.questions << @question
        end
        assert @exam.save
        e = Exam.find(@exam.id)
        assert e.generated?
        assert e.start!
        e = Exam.find(@exam.id)
        assert e.started?
        assert e.check!
        e = Exam.find(@exam.id)
        assert e.checked?
        assert e.complete!
        e = Exam.find(@exam.id)
        assert e.completed?
      end

      context "#draw_questions(max_questions_qnty)" do
        should "return array of 'max_questions_qnty' random questions" do
          min_questions_qnty = Exam::MIN_NUM_OF_QUESTIONS
          max_questions_qnty = Exam::MAX_NUM_OF_QUESTIONS
          @exam.draw_questions(min_questions_qnty)
          @exam.save!
          assert_equal min_questions_qnty, @exam.questions.size
        end
      end

    end

  end

end


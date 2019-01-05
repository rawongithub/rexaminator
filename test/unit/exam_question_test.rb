require 'test_helper'

class ExamQuestionTest < ActiveSupport::TestCase

  context "An ExamQuestion instance" do

    setup do
      @exam_question = FactoryGirl.build(:exam_question)
      @exam = FactoryGirl.build(:exam)
      5.times do
        question = question_from_factory
        @exam_question.exam = @exam
        @exam_question.question = question
        @exam.questions << question
      end
    end

    should belong_to :question
    should belong_to :exam

    should "be destroyed on associated exam instance destroy" do
      assert @exam.save
      assert Exam.exists?(@exam)
      assert_difference('ExamQuestion.count', -5) do
        @exam.destroy
      end
    end

    context "acting as a state machine" do

      setup do
        question = FactoryGirl.build(:question)
        question.save!(:validate => false)
        question.answers = 4.times.map { FactoryGirl.build(:answer, :question => question) }
        question.categories = [FactoryGirl.build(:category, :questions => [question])]
        question.save!
        @eql = FactoryGirl.build(:exam_question, :state => :loaded)
        @eql.exam = @exam
        @eql.question = question
        @eqv = FactoryGirl.build(:exam_question, :state => :viewed)
        @eqv.exam = @exam
        @eqv.question = question
        @eqc = FactoryGirl.build(:exam_question, :state => :completed)
        @eqc.exam = @exam
        @eqc.question = question
      end

      should "have initial state 'loaded'" do
        assert @exam_question.save
        assert @exam_question.loaded?
      end

      should "change from 'loaded' to 'viewed'" do
        assert @eql.loaded?
        assert @eql.view!
        assert eq = ExamQuestion.find(@eql.id)
        assert eq.viewed?
      end

      should "change from any state to 'completed'" do
        [@eql, @eqv, @eqc].each do |eq|
          assert eq.complete!
          assert eq = ExamQuestion.find(eq.id)
          assert eq.completed?
        end
      end

      should "change from 'loaded' to 'loaded_checked'" do
        assert @eql.loaded?
        assert @eql.check!
        assert eq = ExamQuestion.find(@eql.id)
        assert eq.loaded_checked?
      end

      should "change from 'viewed' to 'viewed_checked'" do
        assert @eqv.viewed?
        assert @eqv.check!
        assert eq = ExamQuestion.find(@eqv.id)
        assert eq.viewed_checked?
      end

      should "change from 'completed' to 'completed_checked'" do
        assert @eqc.completed?
        assert @eqc.check!
        assert eq = ExamQuestion.find(@eqc.id)
        assert eq.completed_checked?
      end

      should "change to 'viewed' on 'reset!' from any state" do
        [@eql, @eqv, @eqc].each do |eq|
          assert eq.reset!
          assert eq = ExamQuestion.find(eq.id)
          assert eq.viewed?
        end
      end

    end

  end

end


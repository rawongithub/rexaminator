require 'test_helper'

class ExamQuestionsControllerTest < ActionController::TestCase

  context "ExamQuestionController" do
    setup do
      DatabaseCleaner.clean
      @exam_question = FactoryGirl.build(:exam_question)
      @exam = FactoryGirl.build(:exam)
      5.times do
        @exam_question.exam = @exam
        question = question_from_factory
        @exam_question.question = question
        @exam.questions << question
      end
      @exam_question.save!
      @exam.save!
    end

    context "#POST :update" do
      should "reset state for all answers empty" do
        post :update, :id => @exam_question,
                      :exam_question => {
                                          :answer1 => false,
                                          :answer2 => false,
                                          :answer3 => false,
                                          :answer4 => false
                                        }
        assert_redirected_to go_exam_path(assigns(:exam_question).exam)
        assert_equal @exam_question, assigns(:exam_question)
        assert assigns(:exam_question).viewed?
      end

      should "update with params" do
        post :update, :id => @exam_question,
                      :exam_question => {
                                          :answer1 => true,
                                          :answer2 => true,
                                          :answer3 => false,
                                          :answer4 => false
                                        }
        assert_redirected_to go_exam_path(assigns(:exam_question).exam)
        assert_equal @exam_question, assigns(:exam_question)
        assert assigns(:exam_question).completed?
      end
    end

    context "#GET :review" do
      setup do
        @another_exam = FactoryGirl.build(:exam)
        5.times do
          @another_exam.questions << question_from_factory
        end
        @another_exam.save!
      end

      should "raise RecordNotFound error for exam that does not belongs to current session" do
        session[:exam] = @another_exam
        assert_raise ActiveRecord::RecordNotFound do
          get :review, :id => @exam_question.id, :order_number => 1
        end
      end

      should "review question if exam belongs to current session" do
        session[:exam] = @exam_question.exam.id
        get :review, :id => @exam_question.id, :order_number => 1
        assert_response :success
        assert_template :review
        assert_equal @exam_question.id, assigns(:exam_question).id
        assert_not_nil assigns(:question)
      end
    end
  end

end


require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase

  context "QuestionsController" do

    setup do
      DatabaseCleaner.clean
      authorize_admin
      @question = question_from_factory
      @category1 = FactoryGirl.create(:category)
      @category2 = FactoryGirl.create(:category)
      @category_ids = [@category1.id, @category2.id]
      # @question = @question
    end

    context "#GET :index" do
      should "get list of questions" do
        get :index
        assert_response :success
        assert_not_nil assigns(:num_of_questions)
        assert_not_nil assigns(:questions)
        assert_not_nil assigns(:active_count)
        assert_not_nil assigns(:inactive_count)
      end
    end

    context "#GET :show" do
      should "show question" do
        get :show, :id => @question.id
        assert_response :success
        assert_template :show
        assert_not_nil assigns(:question)
        assert_not_nil assigns(:categories)
      end
    end

    context "#GET :new" do
      should "get new question form" do
        get :new
        assert_response :success
        assert_not_nil assigns(:question)
        assert_not_nil assigns(:categories)
      end
    end

    context "#POST :create" do
      should "not create question for invalid params" do
        assert_no_difference('Question.count') do
          post :create, :question => {:active => true, :body => "", :comment => ""},
                        :answers_attributes => {
                                                 "0" => {:correct => false, :body => ""},
                                                 "1" => {:correct => false, :body => ""},
                                                 "2" => {:correct => false, :body => ""},
                                                 "3" => {:correct => false, :body => ""}
                                                }
        end
        assert_response :success
        assert_template :new
      end

      should "create question for valid params" do
        assert_difference('Question.count') do
          post :create, :question => {:active => true, :body => "Question Body", :comment => "", :category_ids => @category_ids},
                        :answers_attributes => {
                                                 "0" => {:correct => true,  :body => "Ans1"},
                                                 "1" => {:correct => false, :body => "Ans2"},
                                                 "2" => {:correct => true,  :body => "Ans3"},
                                                 "3" => {:correct => false, :body => "Ans4"}
                                                }
        end
        assert_redirected_to question_path(assigns(:question))
      end
    end

    context "#GET :edit" do
      should "get edit question form" do
        get :edit, :id => @question.id
        assert_response :success
        assert_template :edit
      end
    end

    context "#PUT :update" do
      should "not update question forn invalid params" do
        put :update, :id => @question.id,
                     :question => {:active => true, :body => "", :comment => "", :category_ids => []},
                     :answer => {
                                   :answer0 => {:correct => false,  :body => ""},
                                   :answer1 => {:correct => false, :body => ""},
                                   :answer2 => {:correct => false,  :body => ""},
                                   :answer3 => {:correct => false, :body => ""}
                                  }
        assert_response :success
        assert_template :edit
        assert_tag "div", :attributes => {:id => "errorExplanation"}
      end

      should "update question for valid params" do
        put :update, :id => @question.id,
                     :question => {:active => true, :body => "Question Body", :comment => "", :category_ids => @category_ids},
                     :answer => {
                                   :answer0 => {:correct => true,  :body => "Ans1"},
                                   :answer1 => {:correct => false, :body => "Ans2"},
                                   :answer2 => {:correct => true,  :body => "Ans3"},
                                   :answer3 => {:correct => false, :body => "Ans4"}
                                  }
        assert_redirected_to question_path(assigns(:question))
      end
    end

    context "#DELETE :destroy" do
      should "destroy question" do
        assert_difference('Question.count', -1) do
          delete :destroy, :id => @question.id
        end
        assert_redirected_to questions_path
      end
    end
  end
end


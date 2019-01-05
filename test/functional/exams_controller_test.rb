require 'test_helper'

class ExamsControllerTest < ActionController::TestCase

  context "ExamController" do
    setup do
      DatabaseCleaner.clean
      min = Exam::MIN_NUM_OF_QUESTIONS
      max = Exam::MAX_NUM_OF_QUESTIONS
      @valid_num_of_questions = [min, max, min+(max-min)/2]
      @invalid_num_of_questions = [min -1]
      @request = ActionController::TestRequest.new

      @exam = FactoryGirl.build(:exam)
      5.times do
        @exam.questions << question_from_factory
      end
      @exam.save!

      @another_exam = FactoryGirl.build(:exam)
      5.times do
        @another_exam.questions << question_from_factory
      end
      @another_exam.save!
    end

    context "#GET :index" do
      should "not show list of exams for unauthorized users" do
        get :index
        assert_redirected_to login_path
      end

      should "show list of exams for authorized users" do
        authorize_admin
        get :index
        assert_response :success
        assert_equal Exam.count, assigns(:num_of_exams)
        assert_not_nil assigns(:exams)
      end
    end

    context "#GET :new" do
      should "show new form" do
        get :new
        assert_response :success
        assert_not_nil assigns(:exam)
      end
    end

    context "#POST :create" do
      should "create new exam for valid num of questions" do
        @valid_num_of_questions.each do |n|
          assert_difference('Exam.count') do
            post :create, :num_of_questions => n, :sessionid => @request.session.object_id
          end
          assert_redirected_to start_exam_url(assigns(:exam))
          assert_not_nil assigns(:exam)
        end
      end

      should "not create new exam for invalid num of questions" do
        @invalid_num_of_questions.each do |n|
          assert_no_difference('Exam.count') do
            post :create, :num_of_questions => n, :sessionid => @request.session.object_id
          end
        end
        assert_response :success
      end
    end

    context "#GET :start" do
      should "display start page" do
        session[:exam] = @exam.id
        get :start, :id => @exam.id
        assert_response :success
      end
    end

    context "#GET :go" do
      should "redirect to home page for exam that not belongs to current session" do
        session[:exam] = @another_exam.id
        get :go, :id => @exam.id
        assert_redirected_to root_path
      end

      should "display first question" do
        @exam.state = :started
        @exam.save!
        session[:exam] = @exam.id
        get :go, :id => @exam.id
        assert_response :success
        assert_template :go
        assert_equal @exam.id, assigns(:exam).id
        assert_not_nil assigns(:questions)
        assert_not_nil assigns(:exam_questions)
        assert_equal "1", assigns(:question_number)
        assert_not_nil assigns(:num_of_questions)
      end

      should "display proper question" do
        @exam.state = :started
        @exam.save!
        session[:exam] = @exam.id
        get :go, :id => @exam.id, :question => "2"
        assert_response :success
        assert_template :go
        assert_not_nil assigns(:exam)
        assert_not_nil assigns(:questions)
        assert_equal 1, assigns(:questions).size
        assert_not_nil assigns(:question)
        assert_not_nil assigns(:exam_questions)
        assert_not_nil assigns(:exam_question)
        assert_not_nil assigns(:num_of_questions)
        assert_equal "2", assigns(:question_number)
      end
    end

    context "#GET :show" do
      should "show exam" do
        session[:exam] = @exam.id
        get :show, :id => @exam.id
        assert_response :success
        assert_template :show
        assert_equal @exam.id, assigns(:exam).id
      end
    end

    context "#GET :finish" do
      should "not finish (and redirect to home page) exam that does not belonds to current session" do
        @exam.state = :started
        @exam.save!
        session[:exam] = @another_exam.id
        get :finish, :id => @exam.id
        assert_redirected_to root_path
      end

      should "finish exam that belongs to current session" do
        @exam.state = :completed
        @exam.save!
        session[:exam] = @exam.id
        Exam.any_instance.stubs(:score).returns(0)
        get :finish, :id => @exam.id
        assert_response :success
        assert_template :finish
        assert_equal @exam.id, assigns(:exam).id
      end
    end

    context "#POST :destroy" do
      should "destroy exam" do
        authorize_admin
        assert_difference('Exam.count', -1) do
          post :destroy, :id => @exam.id
        end
        assert_redirected_to exams_path
      end
    end
  end

end


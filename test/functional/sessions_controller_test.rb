require 'test_helper'

class SessionControllerTest < ActionController::TestCase

  context "SessionsController" do
    setup do
      @controller = SessionsController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
    end

    context "POST :create" do
      should "create session[:password] and redirect to default admin page" do
        assert_nil session[:password]
        post :create, {:password => 'password'}
        assert_not_nil session[:password]
        assert_redirected_to admin_path
      end
    end

    context "#GET :destroy" do
      should "destroy session[:password] and redirect to login page" do
        session[:password] = 'password'
        assert_not_nil session[:password]
        get :destroy
        assert_nil session[:password]
        assert_redirected_to login_path
      end
    end
  end

end


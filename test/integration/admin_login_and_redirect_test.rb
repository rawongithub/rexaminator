require 'test_helper'

class AdminLoginAndRedirectTest < ActionDispatch::IntegrationTest

  context "Application" do

    setup do
      @request = ActionController::TestRequest.new
    end

    should "redirect to login page on attemp to resctricted area" do
      assert_nil @request.session[:password]
      assert_nil @request.session[:intended_action]
      get "/categories"
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_equal "/login", path
      assert_equal "/categories", @request.session[:intended_action]
    end

  end

end


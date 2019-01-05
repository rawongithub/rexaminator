require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  context "CategoriesController" do
    setup do
      DatabaseCleaner.clean
      @category = FactoryGirl.create(:category)
    end

    context "#GET :index" do
      should "redirect unauthorized users to login page" do
        get :index
        assert_redirected_to login_path
      end

      should "show list of categories for authorized users" do
        authorize_admin
        get :index
        assert_response :success
        assert_template :index
        assert_not_nil assigns(:categories)
      end
    end

    context "#GET :new" do
      should "redirect unauthorized users to login page" do
        get :new
        assert_redirected_to login_path
      end

      should "show new category form for authorized users" do
        authorize_admin
        get :new
        assert_response :success
        assert_template :new
      end
    end

    context "#POST :create" do
      should "redirect unauthorized users to login page" do
        get :create
        assert_redirected_to login_path
      end

      should "not create category for invalid params" do
        authorize_admin
        assert_no_difference('Category.count') do
          post :create, :category => {:name => ''}
        end
        assert_response :success
        assert_template :new
      end

      should "create category for valid params" do
        authorize_admin
        assert_difference('Category.count') do
          post :create, :category => {:name => 'Category4'}
        end
        assert_redirected_to categories_path
      end
    end

    context "#GET :show" do
      should "show category" do
        authorize_admin
        get :show, :id => @category.id
        assert_response :success
        assert_template :show
      end
    end

    context "#POST :edit" do
      should "display category edit form" do
        authorize_admin
        get :edit, :id => @category.id
        assert_response :success
        assert_template :edit
      end
    end

    context "#PUT :update" do
      should "not update category for invalid params" do
        authorize_admin
        put :update, :id => @category.id, :category => {:name => ''}
        assert_response :success
        assert_template :edit
      end

      should "update category for valid params" do
        authorize_admin
        put :update, :id => @category.id, :category => {:name => 'Category5'}
        assert_redirected_to categories_path
      end
    end

    context "#DELETE :destroy" do
      should "destroy category" do
        authorize_admin
        assert_difference('Category.count', -1) do
          delete :destroy, :id => @category.id
        end
        assert_redirected_to categories_path
      end
    end
  end

end


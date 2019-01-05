require 'test_helper'

class AdminCategoriesTest < ActionDispatch::IntegrationTest

  context "Admin" do

    setup do
      DatabaseCleaner.clean
      FactoryGirl.create(:category)
    end

    should "list categories" do
      login_admin
      visit('/categories')
      within("#content h2") do
        assert page.has_content?('Categories')
      end
    end

  end

end


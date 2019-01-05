require 'test_helper'

class AdminQuestionsTest < ActionDispatch::IntegrationTest

  NUM_OF_QUESTIONS = 15

  context "Admin" do

    setup do
      DatabaseCleaner.clean
      NUM_OF_QUESTIONS.times do
        question_from_factory
      end
    end

    should "list questions" do
      login_admin
      visit('/questions')
      within("#content h2") do
        assert page.has_content?("Questions (#{NUM_OF_QUESTIONS})")
      end
    end

  end

end


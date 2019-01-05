require 'test_helper'

class ExamFlowTest < ActionDispatch::IntegrationTest

  context "User" do

    setup do
      DatabaseCleaner.clean
      question_from_factory([true, false, false, false])
      question_from_factory([false, true, false, false])
      question_from_factory([false, false, true, false])
      question_from_factory([false, false, false, true])
    end

    should "create, start, navigate and finish exam" do
      visit('/')
      assert page.has_content?('START HERE')
      fill_in('Number of Questions', :with => '4')
      click_button('Generate New Exam')
      assert page.has_content?('New exam has been successfully generated.')
      assert page.has_content?('Number of questions: 4')

      click_link('Start Exam')
      within("#question h2") do
        assert page.has_content?('Question 1 of 4')
      end
      within("ul#questions_pagination li.current") do
        assert page.has_content?("1")
      end
      within("table.answers_go") do
        check("exam_question[answer1]")
      end
      click_link("Next")
      within("ul#questions_pagination li.current") do
        assert page.has_content?("2")
      end
      within("table.answers_go") do
        check("exam_question[answer1]")
      end
      click_link("Next")
      within("ul#questions_pagination li.current") do
        assert page.has_content?("3")
      end

      page.evaluate_script("window.confirm = function(msg) { return true; }")
      click_link("Finish Exam")
      within("h2") do
        assert page.has_content?("Your Score: 25%")
      end
      within("ul#scoresummary") do
        assert page.has_content?("total: 4")
        assert page.has_content?("viewed: 3")
        assert page.has_content?("completed: 2")
        assert page.has_content?("correct: 1")
      end
      within("ol.questions_summary") do
        click_link("Q1: correct")
      end
      within("h2") do
        assert page.has_content?('Question 1')
      end
      within("table.answers_review") do
        assert has_field?("correct_answer1", checked: true, disabled: true)
        assert has_field?("user_answer1", checked: true, disabled: true)
        assert has_field?("correct_answer2", checked: false, disabled: true)
        assert has_field?("user_answer2", checked: false, disabled: true)
        assert has_field?("correct_answer3", checked: false, disabled: true)
        assert has_field?("user_answer3", checked: false, disabled: true)
        assert has_field?("correct_answer4", checked: false, disabled: true)
        assert has_field?("user_answer4", checked: false, disabled: true)
      end

      click_link("Back")
      within("ol.questions_summary") do
        click_link("Q2: incorrect")
      end
      within("h2") do
        assert page.has_content?('Question 2')
      end
      within("table.answers_review") do
        assert has_field?("correct_answer1", checked: false, disabled: true)
        assert has_field?("user_answer1", checked: true, disabled: true)
        assert has_field?("correct_answer2", checked: true, disabled: true)
        assert has_field?("user_answer2", checked: false, disabled: true)
        assert has_field?("correct_answer3", checked: false, disabled: true)
        assert has_field?("user_answer3", checked: false, disabled: true)
        assert has_field?("correct_answer4", checked: false, disabled: true)
        assert has_field?("user_answer4", checked: false, disabled: true)
      end

      click_link("Back")
      within("ol.questions_summary") do
        click_link("Q3: incorrect")
      end
      within("h2") do
        assert page.has_content?('Question 3')
      end
      within("table.answers_review") do
        assert has_field?("correct_answer1", checked: false, disabled: true)
        assert has_field?("user_answer1", checked: false, disabled: true)
        assert has_field?("correct_answer2", checked: false, disabled: true)
        assert has_field?("user_answer2", checked: false, disabled: true)
        assert has_field?("correct_answer3", checked: true, disabled: true)
        assert has_field?("user_answer3", checked: false, disabled: true)
        assert has_field?("correct_answer4", checked: false, disabled: true)
        assert has_field?("user_answer4", checked: false, disabled: true)
      end

      click_link("Back")
      click_link("New Exam")
      assert new_exam_path, current_path
    end

  end

end


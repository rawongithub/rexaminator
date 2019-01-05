require 'test_helper'

class AnswerTest < ActiveSupport::TestCase

  context "Answer" do

    context "associations" do
      should belong_to :question
    end

    context "validations" do
      should validate_presence_of :body
    end

    context "attributes mass assignment" do
      should allow_mass_assignment_of(:correct)
      should allow_mass_assignment_of(:body)
      should allow_mass_assignment_of(:question_id)
    end

    context "instance" do

      context "accurate?(bool)" do
        should "be accurate for correct answer" do
          correct_answer = FactoryGirl.build(:answer)
          assert correct_answer.accurate?(true)
        end

        should "not be accurate for incorrect answer" do
          incorrect_answer = FactoryGirl.build(:answer, :correct => false)
          assert incorrect_answer.accurate?(false)
        end
      end
    end

  end

end


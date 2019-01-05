require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase

  context "A Feedback instance" do

    should validate_presence_of :body
    should validate_presence_of :category
    should validate_presence_of :question_id

    should "be active on default" do
     q1 = Feedback.new
     assert q1.active?
    end

  end

end


require 'test_helper'

class NotifierTest < ActionMailer::TestCase

  context "feedback email" do

    setup do
      @question = question_from_factory
      @feedback = FactoryGirl.build(:feedback)
      @feedback.question = @question
    end

    should "be delivered" do
      assert ActionMailer::Base.deliveries.empty?
      #testing feedback observer here as well
      assert @feedback.save
  #    Notifier.delay.feedback_notification(feedback)

  #    assert_difference 'Delayed::Job.count', -1, 'Job should execute successfully' do
  #      assert_difference 'ActionMailer::Base.deliveries.count' do
  #        Delayed::Job.work_off
  #      end
  #    end

      assert !ActionMailer::Base.deliveries.empty?
      email = ActionMailer::Base.deliveries.last

      # Test the body of the sent email contains what we expect it to
      assert_equal ["admin@rexaminator"], email.to
      assert_equal "New Feedback!", email.subject
      assert_match /A new feedback has been posted on rexaminator/, email.encoded
    end
  end

end


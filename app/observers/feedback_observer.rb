class FeedbackObserver < ActiveRecord::Observer

  def after_create(feedback)
    Notifier.feedback_notification(feedback).deliver
#    Notifier.delay.feedback_notification(feedback)
  end

end


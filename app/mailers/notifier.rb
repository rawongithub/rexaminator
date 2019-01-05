class Notifier < ActionMailer::Base

  ADMIN_EMAIL = "admin@rexaminator"

  default :from => "rexaminator <no-reply@rexaminator>"

  def feedback_notification(feedback)
    @feedback = feedback
    @question = @feedback.question
    mail(:to => ADMIN_EMAIL, :subject => "New Feedback!")
  end

end


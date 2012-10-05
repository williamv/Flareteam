class ActivationMailer < ActionMailer::Base
  default from: ENV["GMAIL_SMTP_USERNAME"]

  def comment_notification(users, comment)
    mail(bcc: users.map(&:email), 
         subject: comment.teaser,
         body: activation_url(comment.activation))
  end
end

class ActivationMailer < ActionMailer::Base
  default from: ENV["GMAIL_SMTP_USERNAME"]

  def comment_notification(users, comment)
    mail(bcc: users.map(&:email), 
         subject: comment.teaser,
         body: activation_comment_url(comment.id, comment.activation_id))
  end
end

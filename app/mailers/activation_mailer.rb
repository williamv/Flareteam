class ActivationMailer < ActionMailer::Base
  default from: "notifications@flareteam.com"

  def comment_notification(users, comment)
    mail(bcc: users.map(&:email), 
         subject: comment.teaser,
         body: activation_comment_url(comment, comment.activation))
  end
end

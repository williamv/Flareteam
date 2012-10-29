class ActivationMailer < ActionMailer::Base
  default from: ENV["GMAIL_SMTP_USERNAME"]

  def comment_notification(users, comment)
    mail(bcc: users.map(&:email), 
         subject: "New comment on #{comment.activation}",
         body: "#{comment.author} posted about #{comment.activation} at #{comment.posted_at} - #{comment.body} 
         - #{activation_url(comment.activation)}.
         To unsubscribe from notifications, go to #{edit_profile_url}.
         ")
  end
end

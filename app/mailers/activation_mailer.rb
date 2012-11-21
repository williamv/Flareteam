class ActivationMailer < ActionMailer::Base
  add_template_helper CommentsHelper
  default from: ENV["GMAIL_SMTP_USERNAME"]

  def comment_notification(users, comment)
    @comment = comment
    @unsubscribe_url = edit_profile_url
    mail(bcc: users.map(&:email),
         subject: "New comment on #{comment.activation}")
  end
end

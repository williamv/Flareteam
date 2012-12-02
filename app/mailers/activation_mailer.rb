class ActivationMailer < ActionMailer::Base
  add_template_helper CommentsHelper
  default from: ENV["GMAIL_SMTP_USERNAME"]

  def comment_notification(users, comment)
    @comment = comment
    @unsubscribe_url = edit_profile_url
    include_attachments(comment)
    mail(bcc: users.map(&:email),
         subject: "New comment on #{comment.activation}")
  end

private

  def include_attachments(comment)
    return unless comment.attachment.present?
    identifier = File.basename(comment.attachment.file.path)
    attachments[identifier] = comment.attachment.read
  end
end

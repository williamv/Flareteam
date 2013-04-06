class ActivationMailer < ActionMailer::Base
  add_template_helper CommentsHelper
  default from: ENV["GMAIL_SMTP_USERNAME"] || 'accounts@flareteam.com'

  def comment_notification(users, comment)
    @comment = comment
    @unsubscribe_url = edit_profile_url
    include_attachments(comment)
    mail(bcc: users.map(&:email),
         subject: "Update: #{comment.activation} - #{comment.title} at #{comment.created_at.to_s(:short)}")
  end

private

  def include_attachments(comment)
    return unless comment.attachment.present?
    identifier = File.basename(comment.attachment.file.path)
    attachments[identifier] = comment.attachment.read
  end
end

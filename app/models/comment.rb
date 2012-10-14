class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :activation

  validates :user, :activation, presence: true

  attr_accessible :body, :title, :user_id, :activation_id
  default_scope order("created_at DESC")

  alias_attribute :posted_at, :created_at
  after_save :notify_subscribers

  def author
    user.full_name
  end

  def teaser(teaser_length = 15)
    title || body[0..(teaser_length - 1)]
  end

  def notify_subscribers
    ActivationMailer.comment_notification(activation.subscribers, self).deliver
  end
end

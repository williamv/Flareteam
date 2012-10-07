class Activation < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validate :title, :description, :location, presence: true

  attr_accessible :description, :location, :title

  def to_s
    title
  end

  def subscribers
    user.peers.wanting_email_notifications
  end
end

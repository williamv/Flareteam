class Activation < ActiveRecord::Base
  belongs_to :organization
  has_many :comments
  validate :title, :description, :location, :organization, presence: true

  attr_accessible :description, :location, :title

  def to_s
    title
  end

  def subscribers
    organization.members.wanting_email_notifications
  end
end

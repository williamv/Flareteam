class Activation < ActiveRecord::Base
  belongs_to :organization, inverse_of: :activations
  has_many :comments, dependent: :destroy
  validate :title, :description, :location, :organization, presence: true

  attr_accessible :description, :location, :title
  default_scope order("created_at DESC")

  def to_s
    title
  end

  def subscribers
    organization.members.wanting_email_notifications
  end
end

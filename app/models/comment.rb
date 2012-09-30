class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :activation

  validates :user, :activation, presence: true

  attr_accessible :body, :user_id, :activation_id
  alias_attribute :posted_at, :created_at

  def author
    user.full_name
  end
end

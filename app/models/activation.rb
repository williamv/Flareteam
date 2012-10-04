class Activation < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validate :title, :description, :location, presence: true

  attr_accessible :description, :location, :title

  def subscribers
    user.peers
  end
end

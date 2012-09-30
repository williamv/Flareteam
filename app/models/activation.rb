class Activation < ActiveRecord::Base
  has_many :comments
  validate :title, :description, :location, presence: true

  attr_accessible :description, :location, :title
end

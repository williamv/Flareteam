class Activation < ActiveRecord::Base
  validate :title, :description, :location, presence: true

  attr_accessible :description, :location, :title
end

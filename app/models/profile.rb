class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :wants_email_notifications
end

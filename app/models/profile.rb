class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile
  attr_accessible :user_id,
    :wants_email_notifications,
    :time_zone

  def time_zone
    super.presence || Rails.configuration.time_zone
  end
end

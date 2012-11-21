class User < ActiveRecord::Base
  belongs_to :organization
  has_many :activations, primary_key: :organization_id,
                         foreign_key: :organization_id
  has_many :comments
  has_one :profile

  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable, :invitable

  validates :organization, :email, presence: true

  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :emergency_role, :street_address, :city, :state,
    :country, :mobile_phone_number, :landline_phone_number, :organization_id

  after_create :create_profile

  delegate :time_zone, to: :profile

  scope :wanting_email_notifications,
    joins(:profile).where("wants_email_notifications = ?", true)

  def to_s
    full_name.presence || email
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  def peers
    organization.members
  end
end

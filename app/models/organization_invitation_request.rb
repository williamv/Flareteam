class OrganizationInvitationRequest < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user
  belongs_to :requester, class_name: 'User'
  validates :email,
    :user,
    :requester,
    presence: true
  #validates_uniqueness_of :user, scope: :organization
  validate :invitee_belongs_to_organization

  attr_accessible :user, :requester, :email

  def email=(value)
    @email = value
    self.user = User.find_by_email(email)
  end
  
  def email
    @email
  end

  def user=(user)
    self.organization = user.try(:organization)
    super
  end

  def approve
    requester.organization = organization
    requester.save
    destroy
  end

protected

  def invitee_belongs_to_organization
    return if email.blank?

    if user.nil?
      errors.add(:base, 'There is no user with the specified email.')
    elsif user.organization.nil?
      errors.add(:base, 'The specified user does not belong to an organization.')
    end
  end
end

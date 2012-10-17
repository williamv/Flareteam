class Users::InvitationsController < Devise::InvitationsController
  def create
    params[:user].merge!(organization_id: current_user.organization.id)
    super
  end
end

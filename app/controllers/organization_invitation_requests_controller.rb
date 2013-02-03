class OrganizationInvitationRequestsController < ApplicationController
  def new
    @organization_invitation_request = OrganizationInvitationRequest.new
  end

  def create
    @organization_invitation_request = OrganizationInvitationRequest.new(params[:organization_invitation_request])
    @organization_invitation_request.requester = current_user
    if @organization_invitation_request.save
      flash[:notice] = 'An invitation request has been sent.'
      redirect_to edit_organization_invitation_request_path(@organization_invitation_request)
    else
      render :new
    end
  end

  def edit
    @organization_invitation_request = OrganizationInvitationRequest.find(params[:id])
  end

  def update
    @organization_invitation_request = OrganizationInvitationRequest.find(params[:id])
    @organization_invitation_request.approve
    flash[:notice] = 'Invitation request accepted.'
    redirect_to edit_organization_path(current_organization)
  end
  
  def destroy
    OrganizationInvitationRequest.delete(params[:id])
    flash[:notice] = 'Invitation request rejected.'
    redirect_to edit_organization_path(current_organization)
  end
end

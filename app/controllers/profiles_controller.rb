class ProfilesController < ApplicationController
  respond_to :html

  def edit
    @user = current_user
    @profile = current_user.profile
    @organization = current_organization
  end

  def update
    @profile = current_user.profile

    if @profile.update_attributes(params[:profile])
      flash[:notice] = "Profile was successfully updated."
    end
    redirect_to edit_profile_path
  end
end

class ProfilesController < ApplicationController
  respond_to :html

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile

    if @profile.update_attributes(params[:profile])
      flash[:notice] = "Profile was successfully updated."
    end
    redirect_to edit_profile_path
  end
end

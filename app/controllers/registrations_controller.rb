class RegistrationsController < Devise::RegistrationsController
  def update
    @user = User.find(current_user.id)
    if @user.update_without_password(params[:user])
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      flash[:notice] = "Updated successfully"
      redirect_to root_path
    else
      render "edit"
    end
  end
end

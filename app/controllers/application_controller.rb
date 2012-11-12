class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  helper_method :current_organization

  def current_organization
    current_user.try(:organization)
  end
end

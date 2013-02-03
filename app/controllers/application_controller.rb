class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :load_notifications
  helper_method :current_organization

  def current_organization
    current_user.try do |user|
      user.organization.try do |organization|
        OrganizationDecorator.decorate organization
      end
    end
  end

  def load_notifications
    @notifications = current_user.try do |user|
      user.organization.try do |organization|
        organization.organization_invitation_requests.count
      end
    end || 0
  end
end

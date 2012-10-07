require "spec_helper"
include Warden::Test::Helpers

describe "Profile page" do
  let(:user) { FactoryGirl.create(:user) }
  before do
    login_as user, scope: :user
  end
  
  context "updating the user" do
    it "updates the user" do
      visit root_url
      click_on "Profile"
      page.should have_content "Profile Settings"

      notifications_checkbox = page.find("#profile_wants_email_notifications")
      notifications_checkbox.should be_checked
      page.uncheck "profile_wants_email_notifications"

      click_on "Update"
      page.should_not have_content "Please review the problems below:"
      notifications_checkbox.should_not be_checked
    end
  end
end

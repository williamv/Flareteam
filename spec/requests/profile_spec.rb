require "spec_helper"
include Warden::Test::Helpers

describe "Profile page" do
  let(:user) { FactoryGirl.create(:user,
                                  password: "password123") }
  before do
    login_as user, scope: :user
  end
  
  context "updating the user" do
    it "updates the user" do
      visit edit_user_registration_path(user)
      page.should have_content "Edit User"

      fill_in "user_current_password", with: user.password

      notifications_checkbox = page.find("#user_wants_email_notifications")
      notifications_checkbox.should be_checked
      page.uncheck "user_wants_email_notifications"

      click_on "Update"
      page.should_not have_content "Please review the problems below:"
      notifications_checkbox.should_not be_checked
    end
  end
end

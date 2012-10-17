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
      click_on "Account"
      find_field("user_email").value.should == user.email
      fill_in "Mobile phone number", with: "555-123-4567"

      click_on "Update"
      page.should_not have_content "Please review the problems below:"

      click_on "Settings"
      notifications_checkbox = page.find("#profile_wants_email_notifications")
      notifications_checkbox.should be_checked
      page.uncheck "profile_wants_email_notifications"

      click_on "Update"
      page.should_not have_content "Please review the problems below:"
      notifications_checkbox.should_not be_checked
    end
  end

  it "invites a user" do
    visit edit_profile_url
    page.should have_content "Invite people"
    click_on "Invite people"
    
    fill_in "Email", with: "user@example.com"
    click_on "Send an invitation"
    page.should have_content "An invitation email has been sent"
  end
end

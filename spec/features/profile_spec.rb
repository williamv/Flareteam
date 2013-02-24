require 'spec_helper'
include Warden::Test::Helpers

describe 'Profile page' do
  def change_the_profile_mobile
    click_on 'Account'
    find_field('user_email').value.should == user.email
    fill_in 'Mobile phone number', with: '555-123-4567'

    click_on 'Update'
    page.should_not have_content 'Please review the problems below:'
  end

  def register_for_update_emails
    click_on 'Account'
    notifications_checkbox = page.find('#profile_wants_email_notifications')
    notifications_checkbox.should be_checked
    page.uncheck 'profile_wants_email_notifications'
    click_on 'Update'
    page.should_not have_content 'Please review the problems below:'
    notifications_checkbox.should_not be_checked
  end

  context 'within an organization' do
    let(:user) { FactoryGirl.create(:user, :with_organization) }
    before { login_as user, scope: :user }

    context 'updating the user' do
      it 'updates the user' do
        visit root_url

        change_the_profile_mobile
        register_for_update_emails
      end
    end

    it 'invites a user' do
      visit edit_organization_path(user.organization)
      page.should have_content 'Invite'
      
      fill_in 'Email', with: 'user@example.com'
      within '.new_user' do
        click_on 'Invite'
      end
      page.should have_content 'An invitation email has been sent'
    end
  end

  context 'outside an organization' do
    let(:user) { FactoryGirl.create(:user) }
    let(:invitee) { FactoryGirl.create(:user, :with_organization) }
    before { login_as user, scope: :user }

    it 'requests an invitation' do
      visit root_url
      within '.dropdown' do
        click_link 'Organization'
      end

      fill_in 'Email', with: invitee.email
      click_on 'Request invite'
      page.should have_content 'An invitation request has been sent'
    end
  end
end

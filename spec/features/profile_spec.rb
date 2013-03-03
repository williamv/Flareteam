require 'spec_helper'

feature 'User profiles' do
  context 'within an organization' do
    background do
      login_as admin, admin_password
    end

    scenario 'editing the user' do
      click_on 'Account'
      within '.edit_user' do
        fill_in 'Mobile phone number', with: '555-123-4567'
        click_button 'Update'
      end
      page.should have_content 'Updated successfully'

      click_on 'Account'
      within '.edit_profile' do
        notifications_checkbox = page.find('#profile_wants_email_notifications')
        notifications_checkbox.should be_checked
        page.uncheck 'profile_wants_email_notifications'
        click_button 'Update'
      end
      page.should have_content 'Profile was successfully updated'
    end

    scenario 'inviting a user' do
      click_on 'Organization'
      page.should have_content 'Invite'
      
      fill_in 'Email', with: 'user@example.com'
      within '.new_user' do
        click_on 'Invite'
      end
      page.should have_content 'An invitation email has been sent'
    end
  end

  context 'outside an organization' do
    let(:invitee) { FactoryGirl.create(:user, :with_organization) }
    background do
      login_as guest, guest_password
    end

    it 'requests an invitation' do
      within '.dropdown' do
        click_link 'Organization'
      end

      fill_in 'Email', with: invitee.email
      click_on 'Request invite'
      page.should have_content 'An invitation request has been sent'
    end
  end
end

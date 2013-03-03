require 'spec_helper'

feature 'Organizations' do
  let(:organization_name) { Faker::Company.name }

  background do
    login_as admin, admin_password
  end

  scenario 'Creating an organization' do
    visit '/organizations'
    click_link 'New Organization'
    page.should have_content 'New organization'

    fill_in_organization_details

    click_on 'Create Organization'
    page.should have_content organization_name
  end

  context 'An organization exists' do
    let!(:organization) { FactoryGirl.create(:organization) }
    background do
      visit '/organizations'
    end
    
    scenario 'Viewing the organization' do
      page.should have_content organization.name

      click_link organization.name
      page.should have_content organization.name
    end

    scenario 'Editing the organization' do
      click_link organization.name
      click_link 'Edit'
      fill_in 'Name', with: 'A new organization name'
      click_on 'Update Organization'

      page.should have_content 'A new organization name'
    end

    scenario 'Deleting the organization' do
      page.all('.organization a', text: 'Destroy').each(&:click)
      page.should_not have_content organization.name
    end
  end

  context 'accepting an invitation request' do
    let!(:requester) { FactoryGirl.create(:user) }
    let!(:invitation) do
      FactoryGirl.create(
        :organization_invitation_request,
        requester: requester,
        email: admin.email,
        organization: admin.organization)
    end
    background do
      visit '/organizations'
    end

    it 'should get a notification of an invitation request' do
      page.should have_css '.badge', text: '1'
      
      within '.dropdown' do
        click_link 'Organization'
      end
      page.should have_content('You have 1 pending invitation request')
      page.should have_content(admin.email)
    end
  end
end

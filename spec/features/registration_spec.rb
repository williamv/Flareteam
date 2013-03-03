require 'spec_helper'

feature 'Registration' do
  let(:email) { 'tribby@example.com' }
  let(:password) { 'semi89pluck' }
  let!(:organization) { FactoryGirl.create(:organization) }

  scenario 'Registering as a new user' do
    visit '/users/sign_up'

    page.should have_content 'Sign up'

    fill_in 'Email', with: email
    page.find('#user_password').set(password)
    fill_in 'Password confirmation', with: password

    select organization.name, from: 'Organization'

    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Role during emergencies', with: 'Manager'
    fill_in 'Mobile phone number', with: '555-555-555'
    fill_in 'Landline phone number', with: '555-555-5555'

    fill_in 'Street address', with: '123 Evergreen Terrace'
    fill_in 'City', with: 'Springfield'
    fill_in 'State', with: 'IL'

    click_on 'Sign up'
    click_on 'Sign out'
  end
end

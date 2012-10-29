require 'spec_helper'
include Warden::Test::Helpers

describe "Organizations" do
  before do
    login_as users(:eddie), scope: :user
  end

  describe "creating an organization" do
    let(:organization_name) { Faker::Company.name }

    it "creates a new organization" do
      visit new_organization_url
      page.should have_content "New organization"

      fill_in "Name", with: organization_name
      fill_in "Street address", with: Faker::Address.street_address
      fill_in "City", with: Faker::AddressUS.city
      fill_in "State", with: Faker::AddressUS.state_abbr
      fill_in "Zip code", with: Faker::AddressUS.zip_code
      fill_in "Phone", with: Faker::PhoneNumber.phone_number
      fill_in "Primary contact name", with: Faker::Name.name
      fill_in "Primary contact phone", with: Faker::PhoneNumber.phone_number
      fill_in "Primary contact email", with: Faker::Internet.email
      fill_in "Role during emergencies", with: Faker::Lorem.words(20)
      select "1-10", from: "Number of employees"

      click_on "Create Organization"
      page.should have_content organization_name
    end
  end

  context "with an organization" do
    let!(:organization) { FactoryGirl.create(:organization) }

    describe "viewing an organization" do
      it "shows the organization" do
        visit organizations_url
        page.should have_content organization.name

        click_link organization.name
        page.should have_content organization.name
      end
    end

    describe "editing an organization" do
      it "updates the organization" do
        visit organization_url(organization)
        page.should have_content organization.name

        click_link "Edit"
        fill_in "Name", with: "A new organization name"
        click_on "Update Organization"

        page.should have_content "A new organization name"
      end
    end

    describe "destroying an organization" do
      it "destroys the organization" do
        visit organizations_url

        Organization.count.times do
          within(".organization") do
            click_link "Destroy"
          end
        end

        page.should_not have_content organization.name
      end
    end
  end
end

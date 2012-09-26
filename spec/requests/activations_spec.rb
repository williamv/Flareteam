require 'spec_helper'
include Warden::Test::Helpers

describe "Activations" do
  before do
    login_as FactoryGirl.create(:user), scope: :user
  end

  describe "creating an activation" do
    let(:activation_title) { Faker::Company.bs }

    it "creates an activation" do
      visit activations_url

      click_link "New Activation"

      fill_in "Title", with: activation_title
      fill_in "Location", with: Faker::Address.city
      fill_in "Description", with: Faker::Lorem.paragraph
      click_on "Create Activation"

      page.should have_content activation_title
    end 
  end

  context "with an activation" do
    let!(:activation) { FactoryGirl.create(:activation) }
    before { Activation.count.should == 1 }

    describe "viewing the activation" do
      it "shows the activation" do
        visit activations_url
        page.should have_content activation.title

        click_link activation.title
        page.should have_content activation.title
        page.should have_content activation.location
        page.should have_content activation.description
      end 
    end

    describe "editing an activation" do
      let(:new_title) { Faker::Company.bs }

      it "updates the activation" do
        visit activation_url(activation)

        click_link "Edit"
        fill_in "Title", with: new_title

        click_on "Update Activation"
        page.should have_content new_title
      end 
    end

    describe "destroying the activation" do
      it "destroys the activation" do
        visit activation_url(activation)
        click_link "Destroy"

        page.should have_content "Activations"
        page.should_not have_content activation.title
      end 
    end
  end
end

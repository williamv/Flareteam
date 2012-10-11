require 'spec_helper'
include Warden::Test::Helpers

describe "Activations" do
  let(:user) { users(:eddie) }
  before do
    login_as user, scope: :user 
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
        click_link "Delete Activation"

        page.should have_content "Activations"
        page.should_not have_content activation.title
      end 
    end

    describe "commenting on an activation" do
      let(:comment_title) { Faker::Lorem.sentence}
      let(:comment_text) { Faker::Lorem.paragraph }

      it "adds a comment to the activation" do
        visit activation_url(activation)
        fill_in "comment_title", with: comment_title
        fill_in "comment_body", with: comment_text
        click_on "Post Update"

        page.should have_content comment_title
        page.should have_content comment_text
        page.should have_content user.full_name

        within ".comment" do
          click_on "Edit"
        end

        page.should have_content comment_text
        fill_in "comment_body", with: "*redacted*"
        click_on "Update"

        page.should have_content "*redacted*"
      end
    end
  end
end

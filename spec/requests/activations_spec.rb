require 'spec_helper'
include Warden::Test::Helpers

describe 'Activations' do
  let(:activation_title) { Faker::Company.bs }
  let(:user) { FactoryGirl.create(:user, :with_organization) }
  before do
    ActionMailer::Base.deliveries.clear
    login_as user, scope: :user
  end

  describe 'creating an activation' do
    it 'creates an activation' do
      visit activations_url

      click_link 'New Activation'

      fill_in 'Title', with: activation_title
      fill_in 'Location', with: Faker::Address.city
      fill_in 'Description', with: Faker::Lorem.paragraph
      click_on 'Create Activation'

      page.should have_content activation_title
    end
  end

  context 'with an activation' do
    let!(:activation) { FactoryGirl.create(:activation,
                                           organization: user.organization,
                                           title: activation_title) }
    let!(:other_activation) { FactoryGirl.create(:activation) }

    describe 'viewing the activation' do
      it 'shows the activation' do
        visit activations_url
        page.should have_content activation.title
        page.should_not have_content other_activation.title

        click_link activation.title
        page.should have_content activation.title
        page.should have_content activation.location
        page.should have_content activation.description
      end
    end

    describe 'editing an activation' do
      let(:new_title) { Faker::Company.bs }

      it 'updates the activation' do
        visit activation_url(activation)

        click_link 'Edit'
        fill_in 'Title', with: new_title

        click_on 'Update Activation'
        page.should have_content new_title
      end
    end

    describe 'destroying the activation' do
      it 'destroys the activation' do
        visit activation_url(activation)
        click_link 'Delete Activation'

        page.should have_content 'Activations'
        page.should_not have_content activation.title
      end
    end

    describe 'commenting on an activation' do
      let(:comment_title) { Faker::Lorem.sentence}
      let(:comment_text) { Faker::Lorem.paragraph }

      it 'adds a comment and a file to the activation' do
        visit activation_url(activation)
        fill_in 'comment_title', with: comment_title
        fill_in 'comment_body', with: comment_text
        page.attach_file('comment_attachment', Rails.root.join('spec/fixtures/upload.txt'))
        click_on 'Post Update'

        page.should have_content comment_title
        page.should have_content comment_text
        page.should have_content user.full_name

        mail_queue = ActionMailer::Base.deliveries
        mail_queue.size.should == 1
        mail = mail_queue.first
        mail.subject.should include "Update: #{activation.title} - #{comment_title}"
        mail.attachments.size.should == 1

        ActionMailer::Base.deliveries.clear

        within '.comment' do
          click_on 'Edit'
        end

        page.should have_content comment_text
        fill_in 'comment_body', with: '*redacted*'
        click_on 'Update'

        page.should have_content '*redacted*'

        mail_queue = ActionMailer::Base.deliveries
        mail_queue.size.should == 0
      end
    end
  end
end

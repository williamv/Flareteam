require 'spec_helper'

feature 'Activations' do
  scenario 'creating an activation' do
    login_as admin, admin_password
    click_link 'New Activation'

    fill_in 'Title', with: activation_title
    fill_in 'Location', with: Faker::Address.city
    fill_in 'Description', with: Faker::Lorem.paragraph
    click_on 'Create Activation'

    page.should have_content activation_title
  end

  context 'with an activation' do
    let!(:other_activation) { FactoryGirl.create(:activation) }
    background do
      FactoryGirl.create(:activation,
                         organization: admin.organization,
                         title: activation_title)
      login_as admin, admin_password
    end

    scenario 'viewing the activation' do
      visit '/activations'
      page.should have_content activation_title
      page.should_not have_content other_activation.title

      click_link activation_title
      page.should have_content activation_title
    end

    scenario 'editing an activation' do
      new_title = Faker::Company.bs
      view_activation
      click_link 'Edit'
      fill_in 'Title', with: new_title

      click_on 'Update Activation'
      page.should have_content new_title
    end

    scenario 'destroying the activation' do
      view_activation
      click_link 'Delete Activation'

      page.should have_content 'Activations'
      page.should_not have_content activation_title
    end

    describe 'commenting on an activation' do
      let(:comment_title) { Faker::Lorem.sentence }
      let(:comment_text) { Faker::Lorem.paragraph }

      it 'adds a comment and a file to the activation' do
        ActionMailer::Base.deliveries.clear

        view_activation
        fill_in 'comment_title', with: comment_title
        fill_in 'comment_body', with: comment_text
        page.attach_file('comment_attachment', Rails.root.join('spec/fixtures/upload.txt'))
        click_on 'Post Update'

        page.should have_content comment_title
        page.should have_content comment_text
        page.should have_content admin.full_name

        mail_queue = ActionMailer::Base.deliveries
        mail_queue.size.should == 1
        mail = mail_queue.first
        mail.subject.should include "Update: #{activation_title} - #{comment_title}"
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

require 'spec_helper'

feature 'Comments' do
  background do
    activation = FactoryGirl.create(:activation,
                                    organization: admin.organization,
                                    title: activation_title)
    commenter = FactoryGirl.create(:user, :with_organization)
    comment = FactoryGirl.create(:comment,
                                 user: commenter,
                                 title: comment_title,
                                 activation: activation)

    login_as admin, admin_password
  end

  scenario 'removing a comment' do
    view_activation
    edit_comment
    delete_comment
    there_should_be_no_comment
  end
end

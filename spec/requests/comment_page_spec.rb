require 'spec_helper'
include Warden::Test::Helpers

describe "Comments" do
  let(:user) { users(:eddie) }
  before do
    login_as user, scope: :user 
  end

  describe "deleting a comment" do
    let(:activation) { FactoryGirl.create(:activation,
                                          organization: user.organization) }
    let(:comment) { FactoryGirl.create(:comment,
                                       title: "Foo",
                                       activation: activation) }

    it "destroys the comment" do
      visit edit_activation_comment_url(activation, comment.id)

      click_link "Delete Comment"

      page.should have_content comment.activation.title
      page.should_not have_content comment.title
    end 
  end
end

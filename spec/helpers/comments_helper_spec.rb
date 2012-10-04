require 'spec_helper'

describe CommentsHelper do
  let(:user) { FactoryGirl.create(:user) }
  let(:activation) { FactoryGirl.create(:activation) }
  let(:comment) { FactoryGirl.create(:comment, 
                                     title: title,
                                     user: user, 
                                     activation: activation) }
  
  describe ".authorship_details_for" do
    let(:title) { nil }
    it "shows the author and time posted" do
      helper.authorship_details_for(comment).should == 
        "#{user.full_name} - #{comment.created_at.strftime("%B %d, %Y %H:%M:%S")}"
    end
  end
end

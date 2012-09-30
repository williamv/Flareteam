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

  describe ".title_for" do
    context "with a title" do
      let(:title) { Faker::Lorem.sentence }
      it "shows the title" do
        helper.title_for(comment).should == comment.title
      end
    end

    context "without a title" do
      let(:title) { nil }
      it "shows the first 10 characters of the title" do
        helper.title_for(comment).should == comment.body[0..9]
      end
    end
  end
end

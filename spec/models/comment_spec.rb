require 'spec_helper'

describe Comment do
  let(:user) { FactoryGirl.create(:user) }
  let(:activation) { FactoryGirl.create(:activation) }
  let(:comment) { FactoryGirl.create(:comment, 
                                     activation: activation,
                                     user: user) }

  describe "#author" do
    before { comment.user.should_not be_nil }
    
    it "returns the authors full name" do
      comment.author.should == comment.user.full_name
    end
  end
end

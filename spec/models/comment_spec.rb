require 'spec_helper'

describe Comment do
  let(:organization) { organizations(:acme) }
  let(:user) { FactoryGirl.create(:user,
                                  organization: organization)}

  let(:activation) { FactoryGirl.create(:activation,
                                        organization: organization) }

  let(:comment) { FactoryGirl.build(:comment, 
                                    activation: activation,
                                    user: user) }

  before { ActivationMailer.stub(:comment_notification) }

  describe "after_save" do
    it "calls notify_subscribers" do
      comment.should_receive(:notify_subscribers).once
      comment.save!
    end
  end

  describe "#teaser" do
    before do
      comment.stub(:notify_subscribers)
      comment.save!
    end

    context "with no title" do
      before { comment.update_attributes(title: nil) }
      it "returns a substring of the body" do
        comment.teaser(20).should == comment.body[0..19]
      end
    end

    context "with a title" do
      before { comment.update_attributes(title: "Blizzard") }
      it "returns the title" do
        comment.teaser.should == comment.title
      end
    end
  end

  describe "#author" do
    before do
      comment.stub(:notify_subscribers)
      comment.save!
    end

    it "returns the authors full name" do
      comment.user.to_s.should == comment.user.full_name
    end
  end
end

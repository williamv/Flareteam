require 'spec_helper'

describe Comment do
  let(:organization) { organizations(:acme) }
  let(:user) { FactoryGirl.create(:user,
                                  organization: organization)}

  let(:activation) { FactoryGirl.create(:activation,
                                        user: user) }

  let(:comment) { FactoryGirl.create(:comment, 
                                     activation: activation,
                                     user: user) }

  before { ActivationMailer.stub(:comment_notification) }

  describe ".notify_subscribers" do
    it "enqueues a notification email" do
      ActivationMailer.should_receive(:comment_notification).with(
        organization.users, comment)
      comment.notify_subscribers
    end
  end

  describe "#teaser" do
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
    before { comment.user.should_not be_nil }

    it "returns the authors full name" do
      comment.author.should == comment.user.full_name
    end
  end
end

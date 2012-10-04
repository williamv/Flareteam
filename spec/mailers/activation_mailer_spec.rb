require "spec_helper"

describe ActivationMailer do
  describe ".comment_notification" do
    let(:poster) { users(:eddie) }
    let(:commenter) { users(:jane) }
    let(:recipients) { [commenter, poster] }

    let(:activation) { FactoryGirl.create(:activation,
                                         user: poster) }

    let(:comment) { FactoryGirl.create(:comment, 
                                       title: 'Blizzard',
                                       user: poster,
                                       activation: activation) }

    let!(:email) do 
      ActivationMailer.comment_notification(recipients, comment).deliver
    end

    it "enqueues a single email" do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it "sends an email to all members of the organization" do
      email.bcc.should match_array([poster.email, commenter.email])
    end

    it "has the comment title as the subject" do
      email.subject.should include(comment.teaser)
    end

    it "has a link to the comment in the body" do
      email.body.should include(activation_comment_url(comment, comment.activation))
    end
  end 
end

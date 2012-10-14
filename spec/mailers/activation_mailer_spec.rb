require "spec_helper"

describe ActivationMailer do
  describe ".comment_notification" do
    let(:poster) { users(:eddie) }
    let(:commenter) { users(:jane) }
    let(:recipients) { [commenter, poster] }

    let(:activation) { FactoryGirl.create(:activation,
                                         organization: poster.organization) }

    let(:comment) { FactoryGirl.build(:comment, 
                                       title: 'Blizzard',
                                       user: poster,
                                       activation: activation) }

    before { comment.save! }

    it "enqueues a single email" do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it "sends an email to all members of the organization" do
      email = ActivationMailer.comment_notification(recipients, comment).deliver
      email.bcc.should match_array([poster.email, commenter.email])
    end

    it "has the comment title as the subject" do
      email = ActivationMailer.comment_notification(recipients, comment).deliver
      email.subject.should include(activation.title)
    end

    it "has a link to the comment in the body" do
      email = ActivationMailer.comment_notification(recipients, comment).deliver
      email.body.should include(activation_url(activation))
    end

    it "has a the activation title name" do
      email = ActivationMailer.comment_notification(recipients, comment).deliver
      email.body.should include(activation.title)
    end

    it "has a link to the user's profile" do
      email = ActivationMailer.comment_notification(recipients, comment).deliver
      email.body.should include(edit_profile_url)
    end
  end 
end

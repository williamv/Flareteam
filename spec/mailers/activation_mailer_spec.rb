require "spec_helper"

describe ActivationMailer do
  describe ".comment_notification" do
    let(:poster) { FactoryGirl.build(:user) }
    let(:commenter) { FactoryGirl.build(:user) }
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

    let(:email) { ActivationMailer.comment_notification(recipients, comment).deliver }

    it "sends an email to all members of the organization" do
      email.bcc.should match_array([poster.email, commenter.email])
    end

    it "has the comment title as the subject" do
      email.subject.should include(activation.title)
    end

    it "has a link to the comment in the body" do
      email.body.should include(activation_url(activation))
    end

    it "has a the activation title name" do
      email.body.should include(activation.title)
    end

    it "has a link to the user's profile" do
      email.body.should include(edit_profile_url)
    end

    it "includes the user's timezone" do
      email.body.should include('EST')
    end

    context 'when there is an attachment' do
      let(:comment) { FactoryGirl.build(:comment,
                                        title: 'Blizzard',
                                        user: poster,
                                        activation: activation,
                                        attachment: File.open(Rails.root.join('spec/fixtures/upload.txt'))) }

      it 'includes the attachment' do
        email.attachments.size.should == 1
      end

      it 'the attachment has the name from the original file' do
        email.attachments.first.filename.should == 'upload.txt'
      end
    end
  end
end

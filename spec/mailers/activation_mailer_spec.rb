require "spec_helper"

describe ActivationMailer do
  describe ".comment_notification" do
    let(:poster) { FactoryGirl.build(:user, :with_organization) }
    let(:commenter) { FactoryGirl.build(:user, :with_organization) }
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
    let(:text_part) { email.text_part }
    let(:html_part) { email.html_part }

    it 'has a text part and an html part' do
      email.text_part.should be_present
      email.html_part.should be_present
    end

    it "sends an email to all members of the organization" do
      email.bcc.should match_array([poster.email, commenter.email])
    end

    it "has the comment title as the subject" do
      email.subject.should include(activation.title)
    end

    it "has a link to the comment in the body" do
      text_part.body.should include(activation_url(activation))
    end

    it "has a the activation title name" do
      text_part.body.should include(activation.title)
    end

    it "has a link to the user's profile" do
      text_part.body.should include(edit_profile_url)
    end

    it "includes the user's timezone" do
      text_part.body.should include('EST')
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

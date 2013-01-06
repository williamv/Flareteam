require 'spec_helper'

describe Activation do
  let(:organization) { organizations(:acme) }
  let(:poster) { FactoryGirl.create(:user,
                                    organization: organization) }
  let(:subscriber) { FactoryGirl.create(:user,
                                        organization: organization) }
  let(:non_subscriber) { FactoryGirl.create(:user,
                                            organization: organization) }
  let(:non_member) { FactoryGirl.create(:user, :with_organization) }

  let(:activation) { FactoryGirl.create(:activation,
                                        organization: organization)}

  describe "to_s" do
    it "returns the title" do
      activation.to_s.should == activation.title
    end
  end
  
  describe "#subscribers" do
    before do
      non_member.profile.update_attributes(wants_email_notifications: true)
      poster.profile.update_attributes(wants_email_notifications: true)
      subscriber.profile.update_attributes(wants_email_notifications: true)
      non_subscriber.profile.update_attributes(wants_email_notifications: false)
    end
    
    it "returns the parent organizations subscribing users" do
      activation.subscribers.should match_array([poster, subscriber])
    end
  end
end

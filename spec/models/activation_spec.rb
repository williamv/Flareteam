require 'spec_helper'

describe Activation do
  let(:organization) { organizations(:acme) }
  let(:other_organization) { organizations(:acme) }
  let(:poster) { users(:eddie) }
  let(:subscribing_user) { users(:jane) }
  let(:non_member) { FactoryGirl.create(:user,
                                        wants_email_notifications: true) }
  let(:non_subscriber) { FactoryGirl.create(:user,
                                            wants_email_notifications: false) }

  let(:members) { [poster, non_subscriber, subscribing_user] }
  let(:activation) { FactoryGirl.create(:activation,
                                        user: poster)}

  before { organization.users << members }
  
  describe "to_s" do
    it "returns the title" do
      activation.to_s.should == activation.title
    end
  end
  
  describe "#subscribers" do
    it "returns the parent organizations subscribing users" do
      activation.subscribers.should match_array([poster, subscribing_user])
    end
  end
end

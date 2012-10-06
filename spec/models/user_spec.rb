require 'spec_helper'

describe User do
  let(:organization) { organizations(:acme) }
  let(:user) { FactoryGirl.create(:user,
                                  organization: organization) }

  describe "#full_name" do
    it "return the joined first and last names" do
      user.full_name.should == "#{user.first_name} #{user.last_name}"
    end
  end

  describe "#peers" do
    let(:peer) { users(:jane) }

    before { organization.users << peer }
    
    it "returns the other users in the user's organization" do
      user.peers.should match_array organization.users
    end
  end

  describe ".wanting_email_notifications" do
    let(:another_user) { users(:eddie) }
    before { another_user.update_attributes(wants_email_notifications: false) }

    it "includes users who want emails (default case)" do
      User.wanting_email_notifications.should include(user)
    end

    it "omits users who do not want email notifications" do
      User.wanting_email_notifications.should_not include(another_user)
    end
  end
end

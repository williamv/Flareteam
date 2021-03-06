require 'spec_helper'

describe User do
  let(:organization) { organizations(:acme) }
  let(:user) { FactoryGirl.create(:user,
                                  organization: organization) }

  it "has a profile" do
    user.profile.should_not be_nil
  end

  describe "#to_s" do
    context "with a name" do
      it "returns the user's full name" do
        user.to_s.should == "#{user.first_name} #{user.last_name}"
      end
    end

    context "without a name" do
      before { user.update_attributes(first_name: nil, last_name: nil) }
      it "returns the user's email address" do
        user.to_s.should == user.email
      end
    end
  end

  describe "#full_name" do
    it "return the joined first and last names" do
      user.full_name.should == "#{user.first_name} #{user.last_name}"
    end
  end

  describe "#peers" do
    let(:peer) { users(:jane) }

    before { organization.members << peer }
    
    it "returns the other users in the user's organization" do
      user.peers.should match_array organization.members
    end
  end

  describe ".wanting_email_notifications" do
    let(:user_without_email) { FactoryGirl.create(:user, :with_organization) }
    let(:another_user_without_email) { FactoryGirl.create(:user, :with_organization) }
    before do
      user.profile.update_attributes(wants_email_notifications: true)
      user_without_email.profile.update_attributes(wants_email_notifications: false)
      another_user_without_email.profile.update_attributes(wants_email_notifications: false)
    end

    it "only includes users who want emails" do
      User.wanting_email_notifications.should match_array [user]
    end
  end
end

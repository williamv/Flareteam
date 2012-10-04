require 'spec_helper'

describe User do
  let(:organization) { organizations(:acme) }
  let(:user) { FactoryGirl.build(:user,
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
end

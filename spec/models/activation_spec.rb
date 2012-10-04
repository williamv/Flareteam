require 'spec_helper'

describe Activation do
  let(:organization) { organizations(:acme) }
  let(:poster) { users(:eddie) }
  let(:members) { [poster, users(:jane)] }
  let(:activation) { FactoryGirl.create(:activation,
                                        user: poster)}

  before { organization.users << members }
  
  describe "#subscribers" do
    it "returns the parent organizations users" do
      activation.subscribers.should match_array(organization.users)
    end
  end
end

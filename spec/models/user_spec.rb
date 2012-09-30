require 'spec_helper'

describe User do
  describe "#full_name" do
    let(:user) { FactoryGirl.build(:user) }

    it "return the joined first and last names" do
      user.full_name.should == "#{user.first_name} #{user.last_name}"
    end
  end
end

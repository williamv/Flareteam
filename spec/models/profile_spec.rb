require 'spec_helper'

describe Profile do
  describe '#time_zone' do
    it 'defaults to EST' do
      Profile.new.time_zone.name.should == 'Eastern Time (US & Canada)'
    end
  end
end

require 'spec_helper'

describe Profile do
  describe '#time_zone' do
    it 'defaults to EST' do
      Profile.new.time_zone.should == ActiveSupport::TimeZone['EST']
    end
  end
end

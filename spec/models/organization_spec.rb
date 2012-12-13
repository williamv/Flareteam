require 'spec_helper'

describe Organization do
  describe '#destroyable?' do
    context 'island organization' do
      let(:organization) { Organization.new }
      specify { organization.should be_destroyable }
    end

    context 'when the organization has members' do
      let(:organization) { Organization.new {|org| org.members.build} }
      specify { organization.should_not be_destroyable }
    end

    context 'when the organization has activations' do
      let(:organization) { Organization.new {|org| org.activations.build} }
      specify { organization.should_not be_destroyable }
    end
  end
end

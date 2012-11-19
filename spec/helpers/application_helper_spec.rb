require 'spec_helper'

describe ApplicationHelper do
  describe '#help_link' do
    before do
      helper.stub(:current_user)
      helper.stub(:current_organization)
    end

    it 'contains an id' do
      helper.help_link.should have_css('#help')
    end

    it 'gets the current user and organization' do
      helper.should_receive(:current_user)
      helper.should_receive(:current_organization)
      helper.help_link
    end
  end
end

require 'spec_helper'

describe OrganizationDecorator do
  let(:decorated) { OrganizationDecorator.decorate(organization) }
  let(:organization) { FactoryGirl.create(:organization) }

  describe '#to_s' do
    subject { "#{decorated}" }
    it { should == organization.name }
  end

  describe '#show_link' do
    it 'returns the item link' do
      decorated.show_link.should include %[<a href="/organizations/#{organization.id}">]
    end
  end

  describe '#destroy_link' do
    subject { decorated.destroy_link }

    context 'when the organization is destroyable' do
      before { organization.stub(:destroyable?).and_return(true) }
      it { should == %[<a href="/organizations/#{organization.id}" data-confirm="Are you sure?" data-method="delete" rel="nofollow">Destroy</a>] }
    end

    context 'when the organization is not destroyable' do
      before { organization.stub(:destroyable?).and_return(false) }
      it { should be_nil }
    end
  end
end

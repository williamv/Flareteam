require 'spec_helper'

describe CommentsHelper do
  let(:created_at) { Time.utc(1997, 8, 4, 7, 14) }
  let(:author) { double('User', time_zone: 'EST', to_s: 'Sarah Conner') }
  let(:comment) { double('Comment', author: author, created_at: created_at) }

  describe '#authorship_details_for' do
    it 'shows the author and time posted' do
      helper.authorship_details_for(comment).should ==
        'Sarah Conner - August 04, 1997 02:14:00'
    end
  end

  describe '#posted_at' do
    it "formats the time in the author's timezone" do
      helper.posted_at(comment).should ==
        'August 04, 1997 02:14:00'
    end
  end
end

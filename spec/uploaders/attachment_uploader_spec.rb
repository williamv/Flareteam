require "spec_helper"
require "carrierwave/test/matchers"

describe AttachmentUploader do
  include CarrierWave::Test::Matchers
  let(:file) { File.open(Rails.root.join("spec/factories/attachment.xlsx")) }
  let!(:comment) { FactoryGirl.build(:comment) }
  let(:uploader) { AttachmentUploader.new(comment, :attachment) }

  before do
    AttachmentUploader.enable_processing = true
    uploader.store!(file)
  end

  after do
    AttachmentUploader.enable_processing = false
    uploader.remove!
  end

  it "uploads the file" do
    uploader.should_not be_nil
  end
end

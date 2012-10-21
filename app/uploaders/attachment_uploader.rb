# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base
  def extension_white_list
    %w(jpg jpeg gif png pdf xlsx docx xls doc txt)
  end
end

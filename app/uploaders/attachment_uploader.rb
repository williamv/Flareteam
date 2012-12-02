# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base
  def store_dir
    File.join(
      Rails.configuration.upload_dir,
      model.class.to_s.underscore,
      mounted_as.to_s,
      model.id.to_s)
  end

  def extension_white_list
    %w(jpg jpeg gif png pdf xlsx docx xls doc txt)
  end
end

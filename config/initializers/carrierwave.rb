require 'carrierwave/orm/activerecord'
 
Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_public = false
  config.fog_credentials = { provider: 'AWS' }
  config.fog_directory  = 'flareteam-comment-attachments'
end


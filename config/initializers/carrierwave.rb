require 'carrierwave/orm/activerecord'
 
Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_public = false
  config.fog_credentials = { provider: 'AWS' }
  config.fog_directory  = 'flareteam-comment-attachments'
  config.fog_authenticated_url_expiration = 1667001600000
end


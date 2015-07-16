# Encoding: utf-8
class PictureUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick
    process resize_to_limit: [400, 400]
    
    if Rails.env.production?
        storage :fog
    else
        storage :file
    end
    
    # Override the default directory for upload storage
    def store_dir
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
end
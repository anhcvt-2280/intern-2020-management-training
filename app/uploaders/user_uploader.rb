class UserUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end

  def size_range
    Settings.validates.model.course.image.max_size.byte..
        Settings.validates.model.course.image.max_size.byte.megabytes
  end

  process resize_to_fill: [Settings.validates.model.course.image.width,
                           Settings.validates.model.course.image.height]
end

class Blog < ApplicationRecord
  mount_uploader :picture, PictureUploader
end

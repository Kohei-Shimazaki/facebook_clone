class Blog < ApplicationRecord
  mount_uploader :picture, PictureUploader
  validates :content, length: {in: 1..140 }
end

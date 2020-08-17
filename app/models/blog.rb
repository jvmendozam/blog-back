class Blog < ApplicationRecord
    mount_uploader :picture, PictureUploader
    attr_accessor :picture_encode
end

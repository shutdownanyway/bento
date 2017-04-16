class About < ApplicationRecord
      validates :title, :text, presence: true
      mount_uploader :image, ImageUploader
end

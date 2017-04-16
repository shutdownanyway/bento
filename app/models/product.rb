class Product < ApplicationRecord
  has_many :line_items
  belongs_to :category
  validates :name, :description, :price, :quantity, :discount, :category_id, presence: true
    mount_uploader :image, ImageUploader
  # def self.keyword_search(keywords, category)
  #   keywords = "%" + keywords + "%"
  #   Product.where("name ILIKE ? OR description ILIKE ? AND category_id = ?", keywords, keywords, category)
  # end
end

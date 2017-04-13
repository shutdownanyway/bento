class Product < ApplicationRecord
  has_many :line_items
  belongs_to :category


  def self.keyword_search(keywords)
    keywords = "%" + keywords + "%"
    Product.where("name LIKE ? OR description LIKE ?", keywords, keywords)
  end
end

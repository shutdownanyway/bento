class Product < ApplicationRecord
  has_many :line_items
  belongs_to :category
end

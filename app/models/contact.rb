class Contact < ApplicationRecord
  validates :title, :text, presence: true
end

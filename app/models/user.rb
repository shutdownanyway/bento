class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :province
  has_many :orders

  #search_methods :orders
#  scope :orders, ->(id) { joins(:line => :group).where("groups.id = ?", group_id) }
end

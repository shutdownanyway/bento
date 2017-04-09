class Order < ApplicationRecord
  belongs_to :order_status
  has_many :line_items
  #before_save :set_order_status
# before_save :update_subtotal
#
# def subtotal
#   line_items.collect { |oi| oi.valid? ? (oi.quantity * oi.price) : 0 }.sum
# end
# private
 def set_order_status

  self.order_status_id = 1
 end
#
# def update_subtotal
#   self[:subtotal] = subtotal
# end
end

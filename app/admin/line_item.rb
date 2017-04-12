ActiveAdmin.register LineItem do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
permit_params :product_id, :order_id, :price, :quantity, :total
#scope :all, default: true
#scope ("Abandoned") { |item| item.joins(:order).group("id").having("count(orders.order_status_id) = 1")}
#scope ("Abandoned") { |item| item.orders.group_by("id").having("count(orders.order_status_id) = 1")}
def display_name
product.name # or whatever column you want
end
end

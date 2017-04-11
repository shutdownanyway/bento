ActiveAdmin.register List do
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
menu label: "Customers With Orders"
#scope ("Customers with Orders") { |user| user.joins(:orders).group("id").having("count(orders.id) > 0")}
end

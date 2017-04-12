ActiveAdmin.register OrderStatus do
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
permit_params :name.to_s
actions :all, except: [:new, :destroy]
# index do
#   selectable_column
#     id_column
#    column :name
# end
def to_s
  display_name
end
end

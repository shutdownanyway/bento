ActiveAdmin.register Contact do
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
menu label: "Contact"
# menu parent: "Products"
permit_params :title, :text, :phone, :facebook, :twitter, :instagram, :email
actions :all, except: [:new, :destroy]
end

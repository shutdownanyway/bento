ActiveAdmin.register User do

  menu :priority => 4
  menu label: "Customers"
  config.batch_actions = true

  filter :name
  filter :email
  filter :created_at

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :address
    column :city
    column :postal_code
    # column :user.province.name
    column :created_at
    actions
  end

   show :title => :name do
     panel "Order History" do
      table_for(user.orders) do
        column("Order", :sortable => :id) {|order| link_to "##{order.id}", admin_order_path(order) }
        column("State")                   {|order| status_tag(order.status) }
        column("Date", :sortable => :checked_out_at){|order| pretty_format(order.created_at) }
        column("Total")                   {|order| number_to_currency order.total }
      end
     end
   end

  sidebar "Customer Details", :only => :show do
    attributes_table_for user, :name, :email, :created_at
  end

  sidebar "Order History", :only => :show do
    attributes_table_for user do
    #  row("Total Orders") { user.orders.complete.count }
  #    row("Total Value") { number_to_currency user.orders.complete.sum(:total_price) }
    end
  end

  # sidebar "Active Admin Demo" do
  #   render('/admin/sidebar_links', :model => 'users')
  # end
end

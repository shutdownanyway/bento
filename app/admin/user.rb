ActiveAdmin.register User do

  menu :priority => 4
  menu label: "Customers"
  config.batch_actions = true

  filter :name
  filter :email
    scope :all, label: "All Customers", default: true
    scope ("Customers with Orders") { |user| user.joins(:orders).group("id").having("count(orders.id) > 0")}
    #  index as: :block do |user|
      #   div for: user do
      #     resource_selection_cell user
      #
      #
      #
      #     panel "Order History" do
      #      table_for(user.orders) do
      #        column("Order", :sortable => :id) {|order| link_to "##{order.id}", admin_order_path(order) }
      #        column("State")                   {|order| status_tag(order.order_status.name) }
      #        column("Date", :sortable => :checked_out_at){|order| pretty_format(order.created_at) }
      #        column("Products") {
      #          |order|
      #         table_for (order.line_items) do
      #          column("Item", :sortable => :id) {|line_item| link_to "#{line_item.product.name}", admin_line_item_path(line_item)}
      #          column("Qty", :sortable => :id) {|line_item| link_to "#{line_item.quantity}", admin_line_item_path(line_item)}
      #          column("Total", :sortable => :id) {|line_item| link_to "$#{line_item.total}", admin_line_item_path(line_item)}
      #      end
      #    }
      #        column("Grand Total")                   {|order| number_to_currency order.total }
      #
      #      end
      #     end
      # #  end
      # end

#  filter :name, label: "Customers with Orders", collection: proc { Order.all }
  #filter :name, label: "Customer Orders", as: :select, collection: ->{Order.uniq.pluck :user_id}
  #
  #if scope :all
  index :title => "Customers" do

    selectable_column
    id_column
    column :name

    column :email
    column :address
    column :city
    column :postal_code
    column :province
    column :created_at unless params['scope'] == 'Customers with Orders'
    #actions

  end
#else
  # index as: :block do |user|
  #   div for: user do
  #     resource_selection_cell user
  #
  #
  #
  #     panel "Order History" do
  #      table_for(user.orders) do
  #        column("Order", :sortable => :id) {|order| link_to "##{order.id}", admin_order_path(order) }
  #        column("State")                   {|order| status_tag(order.order_status.name) }
  #        column("Date", :sortable => :checked_out_at){|order| pretty_format(order.created_at) }
  #        column("Products") {
  #          |order|
  #         table_for (order.line_items) do
  #          column("Item", :sortable => :id) {|line_item| link_to "#{line_item.product.name}", admin_line_item_path(line_item)}
  #          column("Qty", :sortable => :id) {|line_item| link_to "#{line_item.quantity}", admin_line_item_path(line_item)}
  #          column("Total", :sortable => :id) {|line_item| link_to "$#{line_item.total}", admin_line_item_path(line_item)}
  #      end
  #    }
  #        column("Grand Total")                   {|order| number_to_currency order.total }
  #
  #      end
  #     end
  #   end
  # end
#end



# assumes the model has a scope called ':active'
#scope :active

# renames model scope ':leaves' to ':subcategories'
#scope "Subcategories", :name

# Dynamic scope name
#scope ->{ Date.today.strftime '%A' }, :published_today

# custom scope not defined on the model
#scope("Customers with Orders") ->(:id) { joins(:orders).where("user_id = ?", :id) }

#scope("Customers with orders") { |user| user.where.orders.id > 0}
# conditionally show a custom controller scope
# scope "Published", if: proc { current_admin_user.can? :manage, Users } do |posts|
#  posts.published
# end
def customers_with_orders
  index! as: :block do |user|
    div for: user do
      resource_selection_cell user



      panel "Order History" do
       table_for(user.orders) do
         column("Order", :sortable => :id) {|order| link_to "##{order.id}", admin_order_path(order) }
         column("State")                   {|order| status_tag(order.order_status.name) }
         column("Date", :sortable => :checked_out_at){|order| pretty_format(order.created_at) }
         column("Products") {
           |order|
          table_for (order.line_items) do
           column("Item", :sortable => :id) {|line_item| link_to "#{line_item.product.name}", admin_line_item_path(line_item)}
           column("Qty", :sortable => :id) {|line_item| link_to "#{line_item.quantity}", admin_line_item_path(line_item)}
           column("Total", :sortable => :id) {|line_item| link_to "$#{line_item.total}", admin_line_item_path(line_item)}
       end
     }
         column("Grand Total")                   {|order| number_to_currency order.total }

       end
      end
    end
   end
 end
   show :title => :name do
     panel "Order History" do
      table_for(user.orders) do
        column("Order", :sortable => :id) {|order| link_to "##{order.id}", admin_order_path(order) }
        column("State")                   {|order| status_tag(order.order_status.name) }
        column("Date", :sortable => :checked_out_at){|order| pretty_format(order.created_at) }
        column("Products") {
          |order|
         table_for (order.line_items) do
          column("Item", :sortable => :id) {|line_item| link_to "#{line_item.product.name}", admin_line_item_path(line_item)}
          column("Qty", :sortable => :id) {|line_item| link_to "#{line_item.quantity}", admin_line_item_path(line_item)}
          column("Total", :sortable => :id) {|line_item| link_to "$#{line_item.total}", admin_line_item_path(line_item)}
      end
    }
        column("Grand Total")                   {|order| number_to_currency order.total }

      end
     end
   end

  sidebar "Customer Details", :only => :show do
    attributes_table_for user, :name, :email, :address, :city, :postal_code
  end

  # sidebar "Order History", :only => :show do
  #   attributes_table_for user do
  #   #  row("Total Orders") { user.orders.complete.count }
  # #    row("Total Value") { number_to_currency user.orders.complete.sum(:total_price) }
  #   end
  # end

  # sidebar "Active Admin Demo" do
  #   render('/admin/sidebar_links', :model => 'users')
  # end
end

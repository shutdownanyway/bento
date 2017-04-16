class FixOrderStatusName < ActiveRecord::Migration[5.0]
  def change
     rename_column :order_statuses, :name, :status
  end
end

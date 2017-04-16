class FixOrderStatusStatusName < ActiveRecord::Migration[5.0]
  def change
    rename_column :order_statuses, :status, :name
  end
end

class AddOrderToProvince < ActiveRecord::Migration[5.0]
  def change
    add_reference :provinces, :order, foreign_key: true
  end
end

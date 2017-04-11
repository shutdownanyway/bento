class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :text
    add_column :users, :city, :string
    add_column :users, :postal_code, :string
  end
end

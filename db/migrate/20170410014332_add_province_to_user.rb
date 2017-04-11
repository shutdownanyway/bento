class AddProvinceToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :province, foreign_key: true
  end
end

class AddInstagramToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :instagram, :string
  end
end

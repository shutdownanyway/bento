class AddTwitterToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :twitter, :string
  end
end

class AddSessionToLineItems < ActiveRecord::Migration[5.0]
  def change
    add_column :line_items, :session, :string
  end
end

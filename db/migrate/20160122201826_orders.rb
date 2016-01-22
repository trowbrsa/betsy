class Orders < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_choice, :string
  end
end

class AddShippedToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :shipped, :boolean, :default => 0
  end
end

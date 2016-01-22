class AddPackageInfoToProducts < ActiveRecord::Migration
  def change
    add_column :products, :weight, :integer
    add_column :products, :diameter, :integer
    add_column :products, :width, :integer
    add_column :products, :height, :integer
    add_column :products, :length, :integer
  end
end

class ChangeDefaultForCountry < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.change :country, :string, :default => "US"
    end
  end
end

class AddFeeToGyms < ActiveRecord::Migration
  def change
    add_column :gyms, :registration_fee, :float, :default => 0.0
  end
end

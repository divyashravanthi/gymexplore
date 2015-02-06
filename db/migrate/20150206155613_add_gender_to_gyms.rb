class AddGenderToGyms < ActiveRecord::Migration
  def change
    add_column :gyms, :gender, :integer, :default => 0
  end
end

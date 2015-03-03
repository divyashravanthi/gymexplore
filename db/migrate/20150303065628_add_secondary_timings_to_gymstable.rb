class AddSecondaryTimingsToGymstable < ActiveRecord::Migration
  def change
  	add_column :gyms, :weekday_secondary_from, :string
    add_column :gyms, :weekday_secondary_to, :string
    add_column :gyms, :weekend_secondary_from, :string
    add_column :gyms, :weekend_secondary_to, :string
  end
end

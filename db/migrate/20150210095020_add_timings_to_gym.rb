class AddTimingsToGym < ActiveRecord::Migration
  def change
    add_column :gyms, :weekday_from, :string
    add_column :gyms, :weekday_to, :string
    add_column :gyms, :weekend_from, :string
    add_column :gyms, :weekend_to, :string
  end
end

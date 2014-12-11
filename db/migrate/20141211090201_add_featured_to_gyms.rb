class AddFeaturedToGyms < ActiveRecord::Migration
  def change
    add_column :gyms, :featured, :boolean, :default => false
    add_column :gyms, :rating, :float, :default => 0.0
  end
end

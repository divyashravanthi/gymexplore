class AddVerifiedToGyms < ActiveRecord::Migration
  def change
    add_column :gyms, :verified, :boolean, :default => false
  end
end

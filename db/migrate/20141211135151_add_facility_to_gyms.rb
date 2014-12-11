class AddFacilityToGyms < ActiveRecord::Migration
  def change
    add_column :gyms, :facility, :text
  end
end

class AddOffersToGyms < ActiveRecord::Migration
  def change
    add_column :gyms, :additional_info, :text
    add_column :gyms, :special_offers, :text
  end
end

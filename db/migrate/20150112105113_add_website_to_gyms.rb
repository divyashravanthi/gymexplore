class AddWebsiteToGyms < ActiveRecord::Migration
  def change
    add_column :gyms, :website, :string
  end
end

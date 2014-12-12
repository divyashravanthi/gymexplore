class AddUserToGyms < ActiveRecord::Migration
  def change
    add_reference :gyms, :agency, index: true
    add_foreign_key :gyms, :agencies
  end
end

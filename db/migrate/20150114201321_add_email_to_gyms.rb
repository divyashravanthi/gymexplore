class AddEmailToGyms < ActiveRecord::Migration
  def change
    add_column :gyms, :email, :string
    add_column :gyms, :mobile, :string
  end
end

class AddAdminToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :admin, :boolean, :default => false
  end
end

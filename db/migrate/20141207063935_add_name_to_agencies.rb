class AddNameToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :name, :string
    add_column :agencies, :mobile, :string
  end
end

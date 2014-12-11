class CreateGyms < ActiveRecord::Migration
  def change
    create_table :gyms do |t|
      t.string :name
      t.text :description
      t.float :lang
      t.float :long
      t.text :address

      t.timestamps null: false
    end
  end
end

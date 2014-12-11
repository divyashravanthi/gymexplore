class CreatePricings < ActiveRecord::Migration
  def change
    create_table :pricings do |t|
      t.integer :duration
      t.float :price
      t.belongs_to :gym, index: true

      t.timestamps null: false
    end
    add_foreign_key :pricings, :gyms
  end
end

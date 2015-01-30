class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :name
      t.text :comment
      t.belongs_to :gym, index: true
      t.float :rating

      t.timestamps null: false
    end
    add_foreign_key :reviews, :gyms
  end
end

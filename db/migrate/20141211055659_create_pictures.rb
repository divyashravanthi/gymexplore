class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.belongs_to :gym, index: true
      t.attachment :image

      t.timestamps null: false
    end
    add_foreign_key :pictures, :gyms
  end
end

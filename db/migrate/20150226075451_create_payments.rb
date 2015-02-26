class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :mihpayid
      t.string :mode
      t.string :status
      t.string :txnid
      t.string :firstname
      t.string :email
      t.string :phone
      t.belongs_to :gym, index: true
      t.integer :plan_id
      t.string :payuMoneyId
      t.boolean :transferred, :default => false

      t.timestamps null: false
    end
    add_foreign_key :payments, :gyms
  end
end

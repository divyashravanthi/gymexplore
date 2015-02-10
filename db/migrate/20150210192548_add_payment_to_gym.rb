class AddPaymentToGym < ActiveRecord::Migration
  def change
    add_column :gyms, :is_payment_enabled, :boolean, :default => false
  end
end

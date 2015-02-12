class AddPricingTypeToPricings < ActiveRecord::Migration
  def change
    add_column :pricings, :pricing_type, :string, :default => "regular"
  end
end

class AddTrainersToGyms < ActiveRecord::Migration
  def change
    add_column :gyms, :male_trainers, :integer
    add_column :gyms, :female_trainers, :integer
  end
end

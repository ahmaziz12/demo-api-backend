class AddPropertiesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :address, :string
    add_column :users, :color, :string
    add_column :users, :ratings, :float
    add_column :users, :teachings, :integer
  end
end

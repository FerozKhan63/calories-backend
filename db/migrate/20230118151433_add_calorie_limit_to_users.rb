class AddCalorieLimitToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :calorie_limit, :integer
  end
end

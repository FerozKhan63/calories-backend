class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.string :name
      t.text :description
      t.integer :calorie_intake
      t.date :start_date
      t.date :end_date
      t.references :user

      t.timestamps
    end
  end
end

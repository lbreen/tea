class CreateDrinkPreferences < ActiveRecord::Migration[5.1]
  def change
    create_table :drink_preferences do |t|
      t.string :drink_type, default: "tea"
      t.integer :sugar, default: 0
      t.string :milk, default: "none"
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

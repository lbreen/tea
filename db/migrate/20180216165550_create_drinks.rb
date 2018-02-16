class CreateDrinks < ActiveRecord::Migration[5.1]
  def change
    create_table :drinks do |t|
      t.string :type, default: "tea"
      t.integer :sugar, default: 0
      t.string :milk, default: "none"

      t.timestamps
    end
  end
end

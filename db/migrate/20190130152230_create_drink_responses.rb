class CreateDrinkResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :drink_responses do |t|
      t.references :drink, foreign_key: true
      t.references :user, foreign_key: true
      t.string :drink_type

      t.timestamps
    end
  end
end

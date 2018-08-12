class CreateDrinkNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :drink_notifications do |t|
      t.integer :limit
      t.integer :status
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end

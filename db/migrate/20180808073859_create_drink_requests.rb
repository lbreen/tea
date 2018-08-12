class CreateDrinkRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :drink_requests do |t|
      t.references :user, foreign_key: true
      t.references :drink_notification, foreign_key: true
      t.string :drink_type

      t.timestamps
    end
  end
end

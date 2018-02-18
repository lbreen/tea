class DrinkPreference < ApplicationRecord
  belongs_to :user

  validates :drink_type, inclusion: { in: ["tea", "coffee"] }
  validates :sugar, inclusion: { in: (0..5), message: "Any more than 5 sugars is just wrong!" }
  validates :milk, inclusion: { in: ["None", "A splash", "A dollup", "Very milky", "A cup of milk"] }

  before_create :one_preference_per_drink_type

  def one_preference_per_drink_type
    previous_preferences = DrinkPreference.where(user: self.user, drink_type: self.drink_type)

    unless previous_preferences.empty?
      raise "You have already set your #{previous_preferences[0].drink_type} preferences. Go to account settings to edit these preferences."
    end
  end
end

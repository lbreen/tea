class Group < ApplicationRecord
	has_many :user_groups, dependent: :destroy
	has_many :users, through: :user_groups

	validates :name, length: { maximum: 26 }
end

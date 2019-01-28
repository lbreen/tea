class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :content, presence: true

  paginates_per 10 # Kaminari gem config

  after_create { MessageBroadcastJob.perform_now(self) }


end

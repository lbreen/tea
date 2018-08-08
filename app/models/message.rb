class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :content, presence: true

  paginates_per 10

  after_create_commit {MessageBroadcastJob.perform_now(self)}
end

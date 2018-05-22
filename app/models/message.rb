class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :content, presence: true

  after_create_commit {MessageBroadcastJob.perform_now self}
end

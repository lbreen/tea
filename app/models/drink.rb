class Drink < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_many :drink_responses, dependent: :destroy

  validates :limit, presence: true
  validates :limit, numericality: { only_integer: true, greater_than: 0 }

  enum status: %i[boiling ready]

  after_create :broadcast_create_drink
  # after_update :broadcast_update_drink

  def broadcast_create_drink
    ActionCable.server.broadcast(
      "group_#{group.id}",
      type: 'create_drink',
      partial: render_drink(self),
      current_user_id: user.id
    )
  end

  def broadcast_update_drink
    ActionCable.server.broadcast(
      "group_#{group.id}",
      type: 'update_drink',
      partial: render_drink(self),
      current_user_id: user.id
    )
  end

  private

  def render_drink(drink)
    ApplicationController.renderer.render(
      partial: 'drinks/drink',
      locals: { drink: drink, user: user.id }
    )
  end
end

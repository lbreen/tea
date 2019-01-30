class Drink < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :limit, presence: true
  validates :limit, numericality: { only_integer: true, greater_than: 0 }

  enum status: %i[boiling ready]

  after_create :broadcast_drink

  def broadcast_drink
    ActionCable.server.broadcast(
      "group_#{group.id}",
      type: 'drink',
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

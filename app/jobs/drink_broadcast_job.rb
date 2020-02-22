# class DrinkBroadcastJob < ApplicationJob
#   queue_as :default

#   def perform(drink)
#     ActionCable.server.broadcast(
#       "group_#{drink.group.id}",
#       type: 'drink',
#       drink_partial: render_drink(drink),
#       current_user_id: drink.user.id
#     )
#   end

#   private

#   def render_drink(drink)
#     ApplicationController.renderer.render(
#       partial: 'drinks/drink',
#       locals: { drink: drink }
#     )
#   end
# end

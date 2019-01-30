class DrinkResponsesController < ApplicationController
  before_action :find_drink, only: :create

  def create
    @drink_response = DrinkResponse.new(drink_response_params)
    @drink_response.drink = @drink
    @drink_response.user = current_user
    authorize @drink_response

    if @drink_response.save
      respond_to do |format|
        format.html { redirect_to group_path(@group) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'groups/show' }
        format.js
      end
    end
  end

  private

  def drink_response_params
    params.require(:drink_response).permit(:drink_type)
  end

  def find_drink
    @drink = Drink.find(params[:drink_id])
  end
end

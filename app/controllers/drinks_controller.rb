class DrinksController < ApplicationController
  before_action :find_group, only: :create

  def create
    @drink = Drink.new(drink_params)
    @drink.user = current_user
    @drink.group = @group
    @drink.status = 0

    @drink_responses = []
    @drink_responses << create_current_user_drink_response

    authorize @drink

    if @drink.save
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

  def update
    @drink = Drink.find(params[:id])
    authorize @drink
    @drink.status = 1

    if @drink.save
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

  def create_current_user_drink_response
    DrinkResponse.create(
      user: current_user,
      drink: @drink,
      drink_type: "Tea"
    )
  end

  def drink_params
    params.require(:drink).permit(:status, :limit)
  end

  def find_group
    @group = Group.find(params[:group_id])
  end
end

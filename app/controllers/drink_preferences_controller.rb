class DrinkPreferencesController < ApplicationController
  def new
    @drink_preference = DrinkPreference.new
    @milk_descriptions = ["None", "A splash", "A dollup", "Very milky", "A cup of milk"]
    authorize @drink_preference
  end

  def create
    @drink_preference = DrinkPreference.new(preferences_params)
    @drink_preference.user = current_user
    authorize @drink_preference
    begin
      @drink_preference.save

      redirect_to groups_path
    rescue Exception => e
      @milk_descriptions = ["None", "A splash", "A dollup", "Very milky", "A cup of milk"]
      render :new
      flash[:alert] = e.message
    end
  end

  private

  def preferences_params
    params.require(:drink_preference).permit(:sugar, :milk)
  end
end

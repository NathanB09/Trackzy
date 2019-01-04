class GymsController < ApplicationController
  before_action :find_gym, only: [:show, :destroy]
  before_action :authorized?

  def index
    @gyms = Gym.all
    @gym = Gym.new
    @locals = @gym.local_gyms(params[:postcode]) if params[:postcode] && params[:postcode].length > 0
    flash[:invalid] = "Invalid postcode or town" if params[:postcode] && params[:postcode].length <= 0
  end

  def show
  end

  def new
    @gym = Gym.new
  end

  def create
    @gym = Gym.new(gym_params)
    if @gym.valid?
      @gym.save
      redirect_to @gym
    else
      flash[:errors] = @gym.errors.full_messages
      redirect_to new_gym_path
    end
  end

  def destroy
  end

  private

  def find_gym
    @gym = Gym.find(params[:id])
  end

  def gym_params
    params.require(:gym).permit(:name, :location)
  end
end

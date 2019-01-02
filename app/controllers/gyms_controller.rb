class GymsController < ApplicationController
  before_action :find_gym, only: [:show, :edit, :update, :destroy]

  def index
    @gyms = Gym.all
  end

  def show
  end

  def new
    @gym = Gym.new
  end

  def create
    @gym = Gym.new(gym_params)
    @gym.user_id = current_user.id
    if @gym.valid?
      @gym.save
      redirect_to @gym
    else
      flash[:errors] = @gym.errors.full_messages
      redirect_to new_gym_path
    end
  end

  def edit
  end

  def update
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

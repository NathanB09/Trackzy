class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
      User.new
    end
  end

  def logged_in?
    !!current_user.id
  end

  def authorized?
    if !logged_in?
      flash[:authorized] = "You are not logged in"
      redirect_to login_path
    end
  end

  def authorized_for(user_id)
    if current_user.id != user_id.to_i
      flash[:authorized] = "You are not authorized to view this page"
      redirect_to root_path
    end
  end

  def analytics
    @users = User.all
    @gyms = Gym.all
    @workouts = Workout.all
  end
end

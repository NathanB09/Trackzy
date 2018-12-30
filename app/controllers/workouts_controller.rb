class WorkoutsController < ApplicationController
  before_action :find_workout, only: [:show, :edit, :destroy]

  def index
  end

  def show
  end

  def new
    @workout = Workout.new
    @workout.workout_exercises.build.build_exercise
    @workout.workout_exercises.build.build_exercise
  end

  def create
    workout = Workout.new(workout_params)
    workout.user_id = current_user.id
    if workout.valid?
      workout.save
      redirect_to workout
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_workout
    @workout = Workout.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(:name, :workout_date, workout_exercises_attributes: [exercise_attributes: Exercise.attribute_names.map(&:to_sym)])
  end
end

class SessionsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_session
    @session = Session.find(params[:id])
  end

  def session_params
    params.require(:session).permit()
  end
end

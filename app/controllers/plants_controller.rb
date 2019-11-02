class PlantsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @plants = @user.plants.all
  end
  
  def show
  end
  
  def new
    @plant = Plant.new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
end

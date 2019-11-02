class PlantsController < ApplicationController
  before_action :set_user_id, only: [:show, :index, :create, :new, :edit, :update, :destroy]

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
    @plant = Plant.new(plant_params)
    if @plant.save
      flash[:success] = "新規工場を登録しました。"
      redirect_to user_plants_url(@user)
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
  
  # beforeフィルター
  
  def set_user_id
    @user = User.find(params[:user_id])
  end
  
  private

    def plant_params
      params.require(:plant).permit(:name, :address, :tel_1, :tel_2, :fax, :email, :staff_1,
                                    :staff_2, :note, :user_id)
    end
end

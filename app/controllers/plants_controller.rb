class PlantsController < ApplicationController
  before_action :set_user_id, only: [:show, :index, :create, :new, :edit, :update, :destroy]
  before_action :set_plant, only: [:show, :destroy, :edit, :update]

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
    if @plant.update_attributes(plant_params)
      flash[:success] = "工場情報を更新しました。"
      redirect_to user_plant_url(@user, @plant)
    else
      render :edit      
    end
  end
  
  def destroy
    @plant.destroy
    flash[:success] = "#{@plant.name}のデータを削除しました。"
    redirect_to user_plants_url(@user)
  end
  
  # beforeフィルター
  
  def set_user_id
    @user = User.find(params[:user_id])
  end
  
  def set_plant
    @plant = Plant.find(params[:id])
  end
  
  private

    def plant_params
      params.require(:plant).permit(:name, :address, :tel_1, :tel_2, :fax, :email, :staff_1,
                                    :staff_2, :note, :user_id)
    end
end

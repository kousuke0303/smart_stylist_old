class PlantsController < ApplicationController
  before_action :set_user_by_user_id
  before_action :set_plant, only: [:show, :destroy, :edit, :update]
  before_action :logged_in_user
  before_action :correct_user_by_user_id

  def index
    @plants = @user.plants.all.paginate(page: params[:page])
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
  
  def set_plant
    @plant = Plant.find(params[:id])
  end
  
  private

    def plant_params
      params.require(:plant).permit(:name, :address, :tel_1, :tel_2, :fax, :email, :staff_1,
                                    :staff_2, :note, :user_id)
    end
end

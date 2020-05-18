class PlantsController < ApplicationController

  before_action :set_user_by_user_id
  before_action :set_plant, only: [:show, :destroy, :edit, :update]
  before_action :logged_in_user
  before_action :only_pay_status_true
  before_action :correct_user_by_user_id

  def index
    @plants = @user.plants.all.paginate(page: params[:page])
  end
  
  def show
    @histories = Order.where(plant_id: @plant.id).paginate(page: params[:page],  per_page: 10).order(ordered_on: :desc)
    @plants = @histories
  end
  
  def new
    @plant = Plant.new
    zipcode_api(params[:plant]) if params[:plant]
  end
  
  def create
    if params[:zip_search_button]
      redirect_to new_user_plant_url(@user, plant: plant_params)
    else
      @plant = Plant.new(plant_params)
      if @plant.save
        flash[:success] = "新規工場を登録しました。"
        redirect_to user_plant_url(@user, @plant)
      else
        render :new
      end
    end
  end
  
  def edit
    zipcode_api(params[:plant]) if params[:plant]
  end
  
  def update
    if params[:zip_search_button]
      redirect_to edit_user_plant_url(@user, @plant, plant: plant_params)
    else
      if @plant.update_attributes(plant_params)
        flash[:success] = "工場情報を更新しました。"
        redirect_to user_plant_url(@user, @plant)
      else
        render :edit      
      end
    end
  end
  
  def destroy
    if Order.where(plant_id: @plant.id).count > 0
      flash[:danger] = "オーダーに登録中の工場は削除出来ません。"
      redirect_to user_plant_url(@user, @plant)
    else
      @plant.destroy
      flash[:success] = "#{@plant.name}のデータを削除しました。"
      redirect_to user_plants_url(@user)
    end
  end
  
  # beforeフィルター
  
  def set_plant
    @plant = Plant.find(params[:id])
  end
  
  private

    def plant_params
      params.require(:plant).permit(:name, :address, :tel_1, :tel_2, :fax, :email, :staff_1,
                                    :staff_2, :note, :user_id, :zipcode)
    end
end

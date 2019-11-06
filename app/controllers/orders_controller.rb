class OrdersController < ApplicationController
  before_action :set_user_by_user_id
  before_action :logged_in_user
  before_action :correct_user_by_user_id
  before_action :set_clients_of_user, only: [:new, :create, :edit, :update]
  before_action :set_plants_of_user, only: [:new, :create, :edit, :update]
  
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:success] = "新規オーダーを登録しました。"
      redirect_to root_url
    else
      render :new
    end
  end
  
  def index
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  # beforeフィルター
  
  def set_clients_of_user
    @clients = @user.clients.all
  end
  
  def set_plants_of_user
    @plants = Plant.where(user_id: @user.id)
  end
  
  private

    def order_params
      params.require(:order).permit(:client_id, :kind, :plant_id, :retail, :note, :order_date, :sales_date,
                                    :delivery, :wage, :cloth, :lining, :button, :postage, :other)
    end
end

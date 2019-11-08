class OrdersController < ApplicationController
  before_action :set_user_by_user_id
  before_action :logged_in_user
  before_action :correct_user_by_user_id
  before_action :set_clients_of_user, only: [:new, :create, :edit, :update]
  before_action :set_plants_of_user, only: [:new, :create, :edit, :update]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
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
    @orders = Order.where(user_id: @user.id, sales_date: nil)
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @order.update_attributes(order_params)
      flash[:success] = "オーダー内容を更新しました。"
      redirect_to user_order_url(@user, @order)
    else
      render :edit      
    end
  end
  
  def destroy
    @order.destroy
    flash[:success] = "オーダーを削除しました。"
    redirect_to user_orders_url(@user)
  end
  
  # beforeフィルター
  
  def set_clients_of_user
    @clients = @user.clients.all
  end
  
  def set_plants_of_user
    @plants = Plant.where(user_id: @user.id)
  end
  
  def set_order
    @order = Order.find(params[:id])
  end
  
  private

    def order_params
      params.require(:order).permit(:client_id, :kind, :plant_id, :retail, :note, :order_date, :sales_date,
                                    :delivery, :wage, :cloth, :lining, :button, :postage, :other, :user_id)
    end
end

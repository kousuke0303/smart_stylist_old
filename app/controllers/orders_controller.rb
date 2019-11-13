class OrdersController < ApplicationController
  before_action :set_user, only: [:traded, :unpaid]
  before_action :set_user_by_user_id, only: [:new, :create, :edit, :update, :show, :index, :destroy]
  before_action :logged_in_user
  before_action :correct_user, only: [:traded, :unpaid]
  before_action :correct_user_by_user_id, only: [:new, :create, :edit, :update, :show, :index, :destroy]
  before_action :set_clients_of_user, only: [:new, :create, :edit, :update]
  before_action :set_plants_of_user, only: [:new, :create, :edit, :update]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_one_month, only: :traded
  
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:success] = "新規オーダーを登録しました。"
      if !@order.sales_date.nil?
        redirect_to users_orders_traded_url(@user, date: @order.sales_date.beginning_of_month)
      else
        redirect_to user_orders_url(@user)
      end
    else
      render :new
    end
  end
  
  def index
    @orders = Order.where(user_id: @user.id, sales_date: nil).order(:order_date).paginate(page: params[:page])
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
    if !@order.sales_date.nil?
      redirect_to users_orders_traded_url(@user)
    else
      redirect_to user_orders_url(@user)
    end
  end
  
  def traded
    @all_traded_orders.each do |order|
      @total_retail = @total_retail.to_i + order.retail.to_i
      total_cost(order)
      @all_cost = @all_cost.to_i + total_cost(order).to_i
      gross_profit(order)
      @total_gross_profit = @total_gross_profit.to_i + gross_profit(order).to_i
    end
  end
  
  def unpaid
    @orders = Order.where(user_id: @user.id, unpaid: true).order(:order_date).paginate(page: params[:page])
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
  
  def set_one_month
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day]
    @all_traded_orders = Order.where(user_id: @user.id, sales_date: @first_day..@last_day).order(:sales_date)
    @orders = @all_traded_orders.paginate(page: params[:page])
  end
  
  private

    def order_params
      params.require(:order).permit(:client_id, :kind, :plant_id, :retail, :note, :order_date, :sales_date,
                                    :delivery, :wage, :cloth, :lining, :button, :postage, :other, :user_id,
                                    :wage_pay, :cloth_pay, :lining_pay, :button_pay, :postage_pay, :other_pay)
    end
end

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
    if params[:narrow_client_button]
      redirect_to new_user_order_url(@user, order: order_params)
    else
      @order = Order.new(order_params)
      if @order.save
        flash[:success] = "新規オーダーを登録しました。"
        redirect_to user_order_url(@user, @order)
      else
        render :new
      end
    end
  end
  
  def index
    if params["narrow_year(1i)"] && params["narrow_year(1i)"].present? && params["narrow_month"] && params["narrow_month"].present?
      @searched_date = "#{params["narrow_year(1i)"]}-#{params["narrow_month"]}-01".to_date
      @trading_orders = Order.where(user_id: @user.id, traded: false).
                              where("order_date LIKE ?", "%#{params["narrow_year(1i)"]}-#{params["narrow_month"]}%")
    else
      @trading_orders = Order.where(user_id: @user.id, traded: false)
    end
    @orders = @trading_orders.order(:order_date).paginate(page: params[:page])
    @trading_orders.each do |order|
      @total_retail = @total_retail.to_i + order.retail.to_i
      @all_total_cost = @all_total_cost.to_i + total_cost(order).to_i
      @total_gross_profit = @total_gross_profit.to_i + gross_profit(order).to_i
      @total_deposit = @total_deposit.to_i + order.deposit.to_i
      @totlal_not_deposit = @totlal_not_deposit.to_i + not_deposit(order).to_i
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if params[:narrow_client_button]
      redirect_to edit_user_order_url(@user, @order, order: order_params)
    else
      if @order.update_attributes(order_params)
        del_img
        flash[:success] = "オーダー内容を更新しました。"
        redirect_to user_order_url(@user, @order)
      else
        render :edit      
      end
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
      @all_cost = @all_cost.to_i + total_cost(order).to_i
      @total_gross_profit = @total_gross_profit.to_i + gross_profit(order).to_i
    end
  end
  
  def unpaid
    @all_unpaid_orders = Order.where(user_id: @user.id, unpaid: true)
    @orders = @all_unpaid_orders.order(:order_date).paginate(page: params[:page])
    @all_unpaid_orders.each do |order|
      @all_unpaid = @all_unpaid.to_i + total_unpaid(order).to_i
    end
  end
  
  # beforeフィルター
  
  def set_clients_of_user
    if params[:order] && params[:order][:narrow].present?
      @clients = @user.clients.where("name LIKE ?", "%#{params[:order][:narrow]}%")
    else
      @clients = @user.clients.all
    end
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
    @all_traded_orders = Order.where(user_id: @user.id, traded: true, sales_date: @first_day..@last_day).order(:sales_date)
    @orders = @all_traded_orders.paginate(page: params[:page])
  end
  
  private

    def order_params
      params.require(:order).permit(:client_id, :kind, :plant_id, :retail, :deposit, :note, :order_date, :sales_date,
                                    :delivery, :wage, :cloth, :lining, :button, :postage, :other, :user_id,
                                    :wage_pay, :cloth_pay, :lining_pay, :button_pay, :postage_pay, :other_pay,
                                    :narrow, :img_1, :img_2, :img_3, :img_4, :img_5, :img_6, :img_7, :img_8,
                                    :img_1_note, :img_2_note, :img_3_note, :img_4_note, :img_5_note,:img_6_note,
                                    :img_7_note, :img_8_note, :del_img_1, :del_img_2, :del_img_3, :del_img_4,
                                    :del_img_5, :del_img_6, :del_img_7, :del_img_8)
    end
end

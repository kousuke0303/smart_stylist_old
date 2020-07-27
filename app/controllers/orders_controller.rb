class OrdersController < ApplicationController
  before_action :set_user_by_user_id, only: [:new, :create, :edit, :update, :show, :index, :destroy, :traded, :unpaid]
  before_action :logged_in_user
  before_action :only_pay_status_true
  before_action :correct_user_by_user_id, only: [:new, :create, :edit, :update, :show, :index, :destroy, :traded, :unpaid]
  before_action :set_clients_of_user, only: [:new, :create, :edit, :update]
  before_action :set_plants_of_user, only: [:new, :create, :edit, :update]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_one_month, only: :traded
  
  $order_kinds = {"S": "S", "SP": "SP", "SVP": "SVP", "SPP": "SPP", "SVPP": "SVPP", "WSP": "WSP", "WSPP": "WSPP",
                  "SWVP": "SWVP", "SWVPP": "SWVPP", "V": "V", "WV": "WV", "P": "P", "PP": "PP", "COAT": "COAT",
                  "SHIRT": "SHIRT", "SHOES": "SHOES"}
  
  def new
    @order = @user.orders.build
  end
  
  def create
    if params[:narrow_client_button]
      redirect_to new_user_order_url(@user, order: order_params)
    else
      @order = @user.orders.build(order_params)
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
      @trading_orders = @user.orders.where(traded: false, ordered_on: @searched_date.in_time_zone.all_month)
    else
      @trading_orders = @user.orders.where(traded: false)
    end
    @orders = @trading_orders.order(:ordered_on).paginate(page: params[:page])
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
    if !@order.sold_on.nil?
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
    @all_unpaid_orders = @user.orders.where(unpaid: true)
    @orders = @all_unpaid_orders.order(:ordered_on).paginate(page: params[:page])
    @all_unpaid_orders.each do |order|
      @all_unpaid = @all_unpaid.to_i + total_unpaid(order).to_i
    end
  end
  
  def del_img
    if params[:order][:del_img_1] == "1"
      @order.img_1.purge
      @order.img_1_note = nil
    end
    if params[:order][:del_img_2] == "1"
      @order.img_2.purge
      @order.img_2_note = nil
    end
    if params[:order][:del_img_3] == "1"
      @order.img_3.purge
      @order.img_3_note = nil
    end
    if params[:order][:del_img_4] == "1"
      @order.img_4.purge
      @order.img_4_note = nil
    end
    if params[:order][:del_img_5] == "1"
      @order.img_5.purge
      @order.img_5_note = nil
    end
    if params[:order][:del_img_6] == "1"
      @order.img_6.purge
      @order.img_6_note = nil
    end
    if params[:order][:del_img_7] == "1"
      @order.img_7.purge
      @order.img_7_note = nil
    end
    if params[:order][:del_img_8] == "1"
      @order.img_8.purge
      @order.img_8_note = nil
    end
    @order.save
  end
  
  # beforeフィルター
  
  def set_clients_of_user
    if params[:order] && params[:order][:narrow].present?
      @clients = @user.clients.where("name LIKE ?", "%#{params[:order][:narrow]}%").
                        or(@user.clients.where("kana LIKE ?", "%#{params[:order][:narrow]}%"))
    else
      @clients = @user.clients
    end
  end
  
  def set_plants_of_user
    @plants = @user.plants
  end
  
  def set_order
    @order = Order.find(params[:id])
  end
  
  def set_one_month
    if params["narrow_year(1i)"] && params["narrow_year(1i)"].present? && params["narrow_month"] && params["narrow_month"].present?
      @first_day = "#{params["narrow_year(1i)"]}-#{params["narrow_month"]}-01".to_date
    else
      @first_day = Date.current.beginning_of_month
    end
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day]
    @all_traded_orders = @user.orders.where(traded: true, sold_on: @first_day..@last_day).order(:sold_on)
    @orders = @all_traded_orders.paginate(page: params[:page])
  end
  
  private

    def order_params
      params.require(:order).permit(:client_id, :kind, :plant_id, :retail, :deposit, :note, :ordered_on, :sold_on,
                                    :delivered_on, :wage, :cloth, :lining, :button, :postage, :other,
                                    :wage_pay, :cloth_pay, :lining_pay, :button_pay, :postage_pay, :other_pay,
                                    :narrow, :img_1, :img_2, :img_3, :img_4, :img_5, :img_6, :img_7, :img_8,
                                    :img_1_note, :img_2_note, :img_3_note, :img_4_note, :img_5_note,:img_6_note,
                                    :img_7_note, :img_8_note, :del_img_1, :del_img_2, :del_img_3, :del_img_4,
                                    :del_img_5, :del_img_6, :del_img_7, :del_img_8)
    end
end

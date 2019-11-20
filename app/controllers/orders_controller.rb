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
        if params[:order][:img_1]
        @order.img_1 = "#{@order.id}_1.png"
        File.binwrite("public/order_images/#{@order.img_1}", params[:order][:img_1].read)
        @order.save
        end
        if params[:order][:img_2]
        @order.img_2 = "#{@order.id}_2.png"
        File.binwrite("public/order_images/#{@order.img_2}", params[:order][:img_2].read)
        @order.save
        end
        if params[:order][:img_3]
        @order.img_3 = "#{@order.id}_3.png"
        File.binwrite("public/order_images/#{@order.img_3}", params[:order][:img_3].read)
        @order.save
        end
        if params[:order][:img_4]
        @order.img_4 = "#{@order.id}_4.png"
        File.binwrite("public/order_images/#{@order.img_4}", params[:order][:img_4].read)
        @order.save
        end
        if params[:order][:img_5]
        @order.img_5 = "#{@order.id}_5.png"
        File.binwrite("public/order_images/#{@order.img_5}", params[:order][:img_5].read)
        @order.save
        end
        if params[:order][:img_6]
        @order.img_6 = "#{@order.id}_6.png"
        File.binwrite("public/order_images/#{@order.img_6}", params[:order][:img_6].read)
        @order.save
        end
        if params[:order][:img_7]
        @order.img_7 = "#{@order.id}_7.png"
        File.binwrite("public/order_images/#{@order.img_7}", params[:order][:img_7].read)
        @order.save
        end
        flash[:success] = "新規オーダーを登録しました。"
        redirect_to user_order_url(@user, @order)
      else
        render :new
      end
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
    if params[:narrow_client_button]
      redirect_to edit_user_order_url(@user, @order, order: order_params)
    else
      if @order.update_attributes(order_params)
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
    @all_traded_orders = Order.where(user_id: @user.id, sales_date: @first_day..@last_day).order(:sales_date)
    @orders = @all_traded_orders.paginate(page: params[:page])
  end
  
  private

    def order_params
      params.require(:order).permit(:client_id, :kind, :plant_id, :retail, :note,
                                    :order_date,  :sales_date, :delivery, :wage,
                                    :cloth, :lining, :button, :postage, :other, :user_id,
                                    :wage_pay, :cloth_pay, :lining_pay, :button_pay,
                                    :postage_pay, :other_pay, :narrow, :img_1, :img_2,
                                    :img_3, :img_4, :img_5, :img_6, :img_7, :img_1_note,
                                    :img_2_note, :img_3_note, :img_4_note, :img_5_note,
                                    :img_6_note, :img_7_note)
    end
end

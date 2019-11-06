class OrdersController < ApplicationController
  before_action :set_user_by_user_id
  before_action :logged_in_user
  before_action :correct_user_by_user_id
  
  def new
    @order = Order.new
    @clients = @user.clients.all
    @plants = Plant.where(user_id: @user.id) 
  end
  
  def create
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
end

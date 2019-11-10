class ClientsController < ApplicationController
  before_action :set_user_by_user_id
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user_by_user_id
  
  def index
    if params[:search]
      @clients = Client.where("name LIKE ?", "%#{params[:search]}%").paginate(page: params[:page])
    else
      @clients = Client.all.paginate(page: params[:page])
    end
  end
  
  def show
  end
  
  def new
    @client = Client.new
  end
  
  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:success] = "新規顧客を登録しました。"
      redirect_to user_clients_url(@user)
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @client.update_attributes(client_params)
      flash[:success] = "顧客情報を更新しました。"
      redirect_to user_client_url(@user, @client)
    else
      render :edit      
    end
  end
  
  def destroy
    if Order.where(client_id: @client.id).count > 0
      flash[:danger] = "オーダーに登録中の顧客は削除出来ません。"
      redirect_to user_client_url(@user, @client)
    else
      @client.destroy
      flash[:success] = "#{@client.name}のデータを削除しました。"
      redirect_to user_clients_url(@user)
    end
  end
  
  # beforeフィルター
  
  def set_client
    @client = Client.find(params[:id])
  end
  
  private

    def client_params
      params.require(:client).permit(:name, :address, :tel_1, :tel_2, :fax, :email,
                                     :work, :note, :user_id)
    end
end

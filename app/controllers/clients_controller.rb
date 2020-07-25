class ClientsController < ApplicationController
  before_action :set_user_by_user_id
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :only_pay_status_true
  before_action :correct_user_by_user_id
  
  $birth_months = {"1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "11": 11,"12": 12}
  $birth_days = {"1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10,
                 "11": 11, "12": 12, "13": 13, "14": 14, "15": 15, "16": 16, "17": 17, "18": 18, "19": 19, "20": 20,
                 "21": 21, "22": 22, "23": 23, "24": 24, "25": 25, "26": 26, "27": 27, "28": 28, "29": 29, "30": 30, "31": 31}
  
  def index
    if params[:search]
      @clients = @user.clients.where("name LIKE ?", "%#{params[:search]}%").
                 or(@user.clients.where("kana LIKE ?", "%#{params[:search]}%")).order(:kana).paginate(page: params[:page])
    elsif params[:search_birth].present?
      @clients = @user.clients.where(birth_month: params[:search_birth]).order(:birth_day).paginate(page: params[:page])
    else
      @clients = @user.clients.order(:kana).paginate(page: params[:page])
    end
  end
  
  def show
    @histories = @client.orders.paginate(page: params[:page], per_page: 10).order(ordered_on: :desc)
    @clients = @histories
  end
  
  def new
    @client = @user.clients.build
    zipcode_api(params[:zipcode]) if params[:zipcode]
  end
  
  def create
    if params[:zip_search_button]
      redirect_to new_user_client_url(@user, client: client_params)
    else
      @client = @user.clients.build(client_params)
      if @client.save
        flash[:success] = "新規顧客を登録しました。"
        redirect_to user_client_url(@user, @client)
      else
        render :new
      end
    end
  end
  
  def edit
    zipcode_api(params[:zipcode]) if params[:zipcode]
  end
  
  def update
    if params[:zip_search_button]
      redirect_to edit_user_client_url(@user, @client, client: client_params)
    else
      if @client.update_attributes(client_params)
        flash[:success] = "顧客情報を更新しました。"
        redirect_to user_client_url(@user, @client)
      else
        render :edit      
      end
    end
  end
  
  def destroy
    if @user.orders.where(client_id: @client.id).count > 0
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
      params.require(:client).permit(:name, :kana, :address, :tel_1, :tel_2, :fax, :email, :work,
                                     :note, :zipcode, :birth_year, :birth_month, :birth_day)
    end
end

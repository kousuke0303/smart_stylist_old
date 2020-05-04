class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :update_password, :new_payment, :pay, :edit_card, :update_card]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_or_admin_user, only: [:edit, :update, :show, :destroy]
  before_action :login_once, only: [:new, :create, :reset_password, :update_password]
  before_action :admin_user, only: :index
  
  $questions = {"好きな食べ物は？": "好きな食べ物は？", "好きな映画のタイトルは？": "好きな映画のタイトルは？",
               "ペットの名前は？": "ペットの名前は？", "思い出の場所は？": "思い出の場所は？",
               "座右の銘は？": "座右の銘は？", "応援しているチームは？": "応援しているチームは？"}
  
  def index
    if params[:search]
      @users = User.where("name LIKE ?", "%#{params[:search]}%").paginate(page: params[:page])
    else
      @users = User.all.paginate(page: params[:page])
    end
  end
  
  def show
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    customer = Payjp::Customer.retrieve(@user.customer_id)
    @card_info = customer.cards.retrieve(@user.card_id)
  end
  
  def new
    @user = User.new 
  end
  
  def create
    @user = User.new(user_params)
    if @user.valid?
      ActiveRecord::Base.transaction do
        @user.save
        Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
        customer = Payjp::Customer.create(card: params[:payjpToken], metadata: {user_id: @user.id})
        subscription = Payjp::Subscription.create(plan: 'smartstylisttest', customer: customer.id)
        @user.update_attributes(customer_id: customer.id, card_id: params[:card_id], subscription_id: subscription.id, complete_register: Date.current)
        log_in @user
        flash[:success] = "新規アカウントを登録しました。"
        redirect_to @user
      end
    else
      render :new
    end
  rescue ActiveRecord::RecordInvalid 
    flash[:danger] = "新規アカウントを登録出来ませんでした。"
    redirect_to root_url
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end
  
  def destroy
    if @user.customer_id.present?
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(@user.customer_id)
      customer.delete
    end
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  def reset_password
    @user = User.find(params[:id]) if params[:id]
    if params[:email] && params[:question] && params[:answer]
      if @user = User.find_by(email: params[:email], question: params[:question], answer: params[:answer])
        redirect_to reset_password_users_url(id: @user.id)
      else
        flash[:danger] = "アカウントが見つかりませんでした。"
        redirect_to reset_password_users_url
      end
    end
  end

  def update_password
    if @user.update_attributes(new_password_params)
      flash[:success] = "パスワードを再設定しました。"
      log_in @user
      redirect_to @user
    else
      render :reset_password
    end
  end
  
  def edit_card
  end
  
  def update_card
    if params[:payjpToken]
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(@user.customer_id)
      card = customer.cards.retrieve(@user.card_id)
      flash[:success] = "クレジットカードを変更しました。"
      redirect_to @user
    else
      flash[:danger] = "失敗"
      redirect_to @user
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :question, :answer, :password, :password_confirmation)
    end
    
    def new_password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end

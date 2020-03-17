class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :update_password]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_or_admin_user, only: [:edit, :update, :show, :destroy]
  before_action :login_once, only: [:new, :create]
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
  end
  
  def new
    @user = User.new 
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
       log_in @user
      flash[:success] = "新規作成に成功しました。"
      redirect_to @user
    else
      render :new
    end
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
        flash[:danger] = "アカウントが見つかりませんでした"
        redirect_to reset_password_users_url
      end
    end
  end

  def update_password
    redirect_to reset_password_users_url(id: @user.id)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :question, :answer, :password, :password_confirmation)
    end
end

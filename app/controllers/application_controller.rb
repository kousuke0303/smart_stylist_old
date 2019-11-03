class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # beforeフィルター
    
  # params[:id]からユーザーを取得。
  def set_user
    @user = User.find(params[:id])
  end
  
  # params[:user_id]からユーザーを取得。
  def set_user_by_user_id
    @user = User.find(params[:user_id])
  end

  # ログイン済みのユーザーか確認します。
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
  # アクセスしたユーザーが現在ログインしているユーザー、または管理者か確認します。
  def correct_or_admin_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) || current_user.admin?
  end
  
  # アクセスユーザーが現在ログインしているユーザーか([:idで])確認します。
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  # アクセスユーザーが現在ログインしているユーザーか([user_:idで])確認します。
  def correct_user_by_user_id
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  # システム管理権限所有かどうか判定します。
  def admin_user
    redirect_to root_url unless current_user.admin?
  end
  
  # ログイン済みユーザーのアクセス制限
  def login_once
    if logged_in?
      flash[:info] = "すでにログインしています。"
      redirect_to root_url
    end
  end
  
  # ログイン中のアカウント作成制限
  def only_admin_or_once
    if logged_in? && !current_user.admin?
      flash[:info] = "すでにアカウント作成済です。"
      redirect_to root_url
    end
  end
end

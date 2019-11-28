class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  require 'net/http'
  require 'uri'
  require 'json'
  include SessionsHelper
  include OrdersHelper
  include UsersHelper
  
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
  
  def zipcode_api(parameter)
    zipcode = NKF.nkf('-w -Z4', parameter[:zipcode]).delete("^0-9")
    # hash形式でパラメタ文字列を指定し、URL形式にエンコード
    params = URI.encode_www_form({zipcode: zipcode})
    # URIを解析し、hostやportをバラバラに取得できるようにする
    uri = URI.parse("http://zipcloud.ibsnet.co.jp/api/search?#{params}")
    # リクエストパラメタを、インスタンス変数に格納
    @query = uri.query

    # 新しくHTTPセッションを開始し、結果をresponseへ格納
    response = Net::HTTP.start(uri.host, uri.port) do |http|
      http.open_timeout = 5
      http.read_timeout = 10
      # ここでWebAPIを叩いている
      # Net::HTTPResponseのインスタンスが返ってくる
      http.get(uri.request_uri)
    end
    begin
      case response
      # 成功した場合
      when Net::HTTPSuccess
        # responseのbody要素をJSON形式で解釈し、hashに変換
        @result = JSON.parse(response.body)
        @zipcode = @result["results"][0]["zipcode"]
        @address1 = @result["results"][0]["address1"]
        @address2 = @result["results"][0]["address2"]
        @address3 = @result["results"][0]["address3"]
        @result_address = "〒#{@zipcode}　""#{@address1}""#{@address2}""#{@address3}"
      # 別のURLに飛ばされた場合
      when Net::HTTPRedirection
        @message = "Redirection: code=#{response.code} message=#{response.message}"
      else
        @message = "HTTP ERROR: code=#{response.code} message=#{response.message}"
      end
    rescue IOError => e
      @message = "e.message"
    rescue TimeoutError => e
      @message = "e.message"
    rescue JSON::ParserError => e
      @message = "e.message"
    rescue => e
      @message = "e.message"
    end
  end
end

class PlantsController < ApplicationController

  before_action :set_user_by_user_id
  before_action :set_plant, only: [:show, :destroy, :edit, :update]
  before_action :logged_in_user
  before_action :correct_user_by_user_id

  def index
    @plants = @user.plants.all.paginate(page: params[:page])
  end
  
  def show
  end
  
  def new
    @plant = Plant.new
    
    # hash形式でパラメタ文字列を指定し、URL形式にエンコード
    params = URI.encode_www_form({zipcode: '5940083'})
    # URIを解析し、hostやportをバラバラに取得できるようにする
    uri = URI.parse("http://zipcloud.ibsnet.co.jp/api/search?#{params}")
    # リクエストパラメタを、インスタンス変数に格納
    @query = uri.query

    # 新しくHTTPセッションを開始し、結果をresponseへ格納
    response = Net::HTTP.start(uri.host, uri.port) do |http|
      # 接続時に待つ最大秒数を設定
      http.open_timeout = 5
      # 読み込み一回でブロックして良い最大秒数を設定
      http.read_timeout = 10
      # ここでWebAPIを叩いている
      # Net::HTTPResponseのインスタンスが返ってくる
      http.get(uri.request_uri)
    end
    # 例外処理の開始
    begin
      # responseの値に応じて処理を分ける
      case response
      # 成功した場合
      when Net::HTTPSuccess
        # responseのbody要素をJSON形式で解釈し、hashに変換
        @result = JSON.parse(response.body)
        # 表示用の変数に結果を格納
        @zipcode = @result["results"][0]["zipcode"]
        @address1 = @result["results"][0]["address1"]
        @address2 = @result["results"][0]["address2"]
        @address3 = @result["results"][0]["address3"]
      # 別のURLに飛ばされた場合
      when Net::HTTPRedirection
        @message = "Redirection: code=#{response.code} message=#{response.message}"
      # その他エラー
      else
        @message = "HTTP ERROR: code=#{response.code} message=#{response.message}"
      end
    # エラー時処理
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
  
  def create
    if params[:zip_search_button]
      redirect_to new_user_plant_url(@user, plant: plant_params)
    else
      @plant = Plant.new(plant_params)
      if @plant.save
        flash[:success] = "新規工場を登録しました。"
        redirect_to user_plants_url(@user)
      else
        render :new
      end
    end
  end
  
  def edit
  end
  
  def update
    if @plant.update_attributes(plant_params)
      flash[:success] = "工場情報を更新しました。"
      redirect_to user_plant_url(@user, @plant)
    else
      render :edit      
    end
  end
  
  def destroy
    if Order.where(plant_id: @plant.id).count > 0
      flash[:danger] = "オーダーに登録中の工場は削除出来ません。"
      redirect_to user_plant_url(@user, @plant)
    else
      @plant.destroy
      flash[:success] = "#{@plant.name}のデータを削除しました。"
      redirect_to user_plants_url(@user)
    end
  end
  
  # beforeフィルター
  
  def set_plant
    @plant = Plant.find(params[:id])
  end
  
  private

    def plant_params
      params.require(:plant).permit(:name, :address, :tel_1, :tel_2, :fax, :email, :staff_1,
                                    :staff_2, :note, :user_id)
    end
end

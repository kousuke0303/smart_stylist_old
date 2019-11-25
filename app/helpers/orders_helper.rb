module OrdersHelper
  require 'mini_magick'
  
  def new_img
    if params[:order][:img_1]
      @order.img_1 = "#{@order.id}_1.png"
      image = MiniMagick::Image.read(params[:order][:img_1])
      image.resize "570x760"
      image.write "public/order_images/#{@order.img_1}"
    end
    if params[:order][:img_2]
      @order.img_2 = "#{@order.id}_2.png"
      image = MiniMagick::Image.read(params[:order][:img_2])
      image.resize "570x760"
      image.write "public/order_images/#{@order.img_2}"
    end
    if params[:order][:img_3]
      @order.img_3 = "#{@order.id}_3.png"
      image = MiniMagick::Image.read(params[:order][:img_3])
      image.resize "570x760"
      image.write "public/order_images/#{@order.img_3}"
    end
    if params[:order][:img_4]
      @order.img_4 = "#{@order.id}_4.png"
      image = MiniMagick::Image.read(params[:order][:img_4])
      image.resize "570x760"
      image.write "public/order_images/#{@order.img_4}"
    end
    if params[:order][:img_5]
      @order.img_5 = "#{@order.id}_5.png"
      image = MiniMagick::Image.read(params[:order][:img_5])
      image.resize "570x760"
      image.write "public/order_images/#{@order.img_5}"
    end
    if params[:order][:img_6]
      @order.img_6 = "#{@order.id}_6.png"
      image = MiniMagick::Image.read(params[:order][:img_6])
      image.resize "570x760"
      image.write "public/order_images/#{@order.img_6}"
    end
    if params[:order][:img_7]
      @order.img_7 = "#{@order.id}_7.png"
      image = MiniMagick::Image.read(params[:order][:img_7])
      image.resize "570x760"
      image.write "public/order_images/#{@order.img_7}"
    end
    @order.save
  end
  
  def update_img
    if params[:order][:del_img_1_check] == "1"
      @order.img_1 = nil
      @order.img_1_note = nil
      @order.del_img_1_check = false
      File.delete("public/order_images/#{@order.id}_1.png")
    elsif params[:order][:img_1]
      File.delete("public/order_images/#{@order.id}_1.png") if File.exist?("public/order_images/#{@order.id}_1.png")
      @order.img_1 = "#{@order.id}_1.png"
      image = MiniMagick::Image.read(params[:order][:img_1])
      image.resize "570x760"
      image.write "public/order_images/#{@order.img_1}"
    end
    if params[:order][:del_img_2_check] == "1"
      @order.img_2 = nil
      @order.img_2_note = nil
      @order.del_img_2_check = false
      File.delete("public/order_images/#{@order.id}_2.png")
    elsif params[:order][:img_2]
      File.delete("public/order_images/#{@order.id}_2.png") if File.exist?("public/order_images/#{@order.id}_2.png")
      @order.img_2 = "#{@order.id}_2.png"
      image = MiniMagick::Image.read(params[:order][:img_2])
      image.resize "570x760"
      image.write "public/order_images/#{@order.img_2}"
    end
    if params[:order][:del_img_3_check] == "1"
      @order.img_3 = nil
      @order.img_3_note = nil
      @order.del_img_3_check = false
      File.delete("public/order_images/#{@order.id}_3.png")
    elsif params[:order][:img_3]
      File.delete("public/order_images/#{@order.id}_3.png") if File.exist?("public/order_images/#{@order.id}_3.png")
      @order.img_3 = "#{@order.id}_3.png"
      image = MiniMagick::Image.read(params[:order][:img_3])
      image.resize "570x760"
      image.write "public/order_images/#{@order.img_3}"
    end
    if params[:order][:del_img_4_check] == "1"
      @order.img_4 = nil
      @order.img_4_note = nil
      @order.del_img_4_check = false
      File.delete("public/order_images/#{@order.id}_4.png")
    elsif params[:order][:img_4]
      File.delete("public/order_images/#{@order.id}_4.png") if File.exist?("public/order_images/#{@order.id}_4.png")
      @order.img_4 = "#{@order.id}_4.png"
      image = MiniMagick::Image.read(params[:order][:img_4])
      image.resize "570x760"
      image.write "public/order_images/#{@order.img_4}"
    end
    if params[:order][:del_img_5_check] == "1"
      @order.img_5 = nil
      @order.img_5_note = nil
      @order.del_img_5_check = false
      File.delete("public/order_images/#{@order.id}_5.png")
    elsif params[:order][:img_5]
      File.delete("public/order_images/#{@order.id}_5.png") if File.exist?("public/order_images/#{@order.id}_5.png")
      @order.img_5 = "#{@order.id}_5.png"
      image = MiniMagick::Image.read(params[:order][:img_5])
      image.resize "570x760"
      image.write "public/order_images/#{@order.img_5}"
    end
    if params[:order][:del_img_6_check] == "1"
      @order.img_6 = nil
      @order.img_6_note = nil
      @order.del_img_6_check = false
      File.delete("public/order_images/#{@order.id}_6.png")
    elsif params[:order][:img_6]
      File.delete("public/order_images/#{@order.id}_6.png") if File.exist?("public/order_images/#{@order.id}_6.png")
      @order.img_6 = "#{@order.id}_6.png"
      image = MiniMagick::Image.read(params[:order][:img_6])
      image.resize "570x760"
      image.write "public/order_images/#{@order.img_6}"
    end
    if params[:order][:del_img_7_check] == "1"
      @order.img_7 = nil
      @order.img_7_note = nil
      @order.del_img_7_check = false
      File.delete("public/order_images/#{@order.id}_7.png")
    elsif params[:order][:img_7]
      File.delete("public/order_images/#{@order.id}_7.png") if File.exist?("public/order_images/#{@order.id}_7.png")
      @order.img_7 = "#{@order.id}_7.png"
      image = MiniMagick::Image.read(params[:order][:img_7])
      image.resize "570x760"
      image.write "public/order_images/#{@order.img_7}"
    end
    @order.save
  end
  
  def del_img_with_order
    File.delete("public/order_images/#{@order.id}_1.png") if File.exist?("public/order_images/#{@order.id}_1.png")
    File.delete("public/order_images/#{@order.id}_2.png") if File.exist?("public/order_images/#{@order.id}_2.png")
    File.delete("public/order_images/#{@order.id}_3.png") if File.exist?("public/order_images/#{@order.id}_3.png")
    File.delete("public/order_images/#{@order.id}_4.png") if File.exist?("public/order_images/#{@order.id}_4.png")
    File.delete("public/order_images/#{@order.id}_5.png") if File.exist?("public/order_images/#{@order.id}_5.png")
    File.delete("public/order_images/#{@order.id}_6.png") if File.exist?("public/order_images/#{@order.id}_6.png")
    File.delete("public/order_images/#{@order.id}_7.png") if File.exist?("public/order_images/#{@order.id}_7.png")
  end

  def client_name(order)
    client = Client.find(order.client_id)
    client.name
  end
  
  def show_cost_detail(detail)
    detail.present? ? "#{detail}円" : "未入力"
  end
  
  def plant_name(order)
    plant = Plant.find(order.plant_id)
    plant.name
  end
  
  def kind_name(order)
    case order.kind
      when "1"
        kind = "SP"
      when "2"
        kind = "SVP"
      when "3"
        kind = "SPP"
      when "4"
        kind = "SVPP"
      when "5"
        kind = "V"
      when "6"
        kind = "P"
      when "7"
        kind = "PP"
      when "8"
        kind = "Sh"
    end
    kind
  end
  
  def total_cost(order)
    order.wage.present? ? wage = order.wage.to_i : wage = 0
    order.cloth.present? ? cloth = order.cloth.to_i : cloth = 0
    order.lining.present? ? lining = order.lining.to_i : lining = 0
    order.button.present? ? button = order.button.to_i : button = 0
    order.postage.present? ? postage = order.postage.to_i : postage = 0
    order.other.present? ? other = order.other.to_i : other = 0
    total_cost = wage + cloth + lining + button + postage + other
  end
  
  def gross_profit(order)
    gross_profit = order.retail.to_i - total_cost(order).to_i
  end
  
  def put_price_or_bar(integer)
    integer > 0 ? "#{integer}円" : "--"
  end
  
  def put_total_price_or_bar(total)
    if total
      "#{total}円"
    else
      "--"
    end
  end
  
  def wage_paid_or_not(order)
    if order.wage.present?
      order.wage_pay == true ? "支払済" : "未払い"
    end
  end
  
  def total_unpaid(order)
    unpaid_w = order.wage if order.wage.present? && order.wage_pay == false
    unpaid_c = order.cloth if order.cloth.present? && order.cloth_pay == false
    unpaid_l = order.wage if order.lining.present? && order.lining_pay == false
    unpaid_b = order.button if order.button.present? && order.button_pay == false
    unpaid_p = order.postage if order.postage.present? && order.postage_pay == false
    unpaid_o = order.other if order.other.present? && order.other_pay == false
    @total_unpaid = unpaid_w.to_i + unpaid_c.to_i + unpaid_l.to_i +
                   unpaid_b.to_i + unpaid_p.to_i + unpaid_o.to_i
  end
  
  def all_unpaid(user)
    orders = Order.where(user_id: user.id, unpaid: true)
    orders.each do |order|
      total_unpaid(order)
      @all_unpaid = @all_unpaid.to_i + total_unpaid(order).to_i
    end
      @all_unpaid
  end
end

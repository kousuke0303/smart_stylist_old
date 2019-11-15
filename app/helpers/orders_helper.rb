module OrdersHelper
  
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

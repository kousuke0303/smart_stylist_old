module OrdersHelper

  # オーダーの持つ顧客名を返す
  def client_name(order)
    client = Client.find(order.client_id)
    client.name
  end
  
  # 費用詳細の状態を返す
  def show_cost_detail(detail)
    detail.present? ? "#{detail}円" : "未入力"
  end
  
  # オーダーの持つ工場名名を返す
  def plant_name(order)
    plant = Plant.find(order.plant_id)
    plant.name
  end
  
  # 未入金額を算出
  def not_deposit(order)
    @not_deposit = order.retail.to_i - order.deposit.to_i
  end
  
  # 費用合計を算出
  def total_cost(order)
    order.wage.present? ? wage = order.wage.to_i : wage = 0
    order.cloth.present? ? cloth = order.cloth.to_i : cloth = 0
    order.lining.present? ? lining = order.lining.to_i : lining = 0
    order.button.present? ? button = order.button.to_i : button = 0
    order.postage.present? ? postage = order.postage.to_i : postage = 0
    order.other.present? ? other = order.other.to_i : other = 0
    total_cost = wage + cloth + lining + button + postage + other
  end
  
  # 粗利を算出
  def gross_profit(order)
    gross_profit = order.retail.to_i - total_cost(order).to_i
  end
  
  def put_price_or_bar(integer)
    integer > 0 ? "#{integer}円" : "--"
  end

  # オーダーの未払い費用合計を算出
  def total_unpaid(order)
    unpaid_w = order.wage if order.wage.present? && order.wage_pay == false
    unpaid_c = order.cloth if order.cloth.present? && order.cloth_pay == false
    unpaid_l = order.lining if order.lining.present? && order.lining_pay == false
    unpaid_b = order.button if order.button.present? && order.button_pay == false
    unpaid_p = order.postage if order.postage.present? && order.postage_pay == false
    unpaid_o = order.other if order.other.present? && order.other_pay == false
    @total_unpaid = unpaid_w.to_i + unpaid_c.to_i + unpaid_l.to_i + unpaid_b.to_i + unpaid_p.to_i + unpaid_o.to_i
  end
end

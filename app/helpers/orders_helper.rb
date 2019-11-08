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
    total_cost > 0 ? "#{total_cost}円" : "未入力" 
  end
end

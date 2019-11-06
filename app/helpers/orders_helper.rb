module OrdersHelper
  def client_name(order)
    client = Client.find(order.client_id)
    client.name
  end
  
  def plant_name(order)
    plant = Plant.find(order.plant_id)
    plant.name
  end
  
  def total_cost(order)
    total_cost = order.wage.to_i + order.cloth.to_i + order.lining.to_i +
                 order.button.to_i + order.delivery.to_i + order.other.to_i
    total_cost
  end
end

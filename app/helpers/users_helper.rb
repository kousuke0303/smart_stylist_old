module UsersHelper
  def del_img_with_user
    orders = Order.where(user_id: @user.id)
    orders.each do |order|
      File.delete("public/order_images/#{order.id}_1.png") if File.exist?("public/order_images/#{order.id}_1.png")
      File.delete("public/order_images/#{order.id}_2.png") if File.exist?("public/order_images/#{order.id}_2.png")
      File.delete("public/order_images/#{order.id}_3.png") if File.exist?("public/order_images/#{order.id}_3.png")
      File.delete("public/order_images/#{order.id}_4.png") if File.exist?("public/order_images/#{order.id}_4.png")
      File.delete("public/order_images/#{order.id}_5.png") if File.exist?("public/order_images/#{order.id}_5.png")
      File.delete("public/order_images/#{order.id}_6.png") if File.exist?("public/order_images/#{order.id}_6.png")
      File.delete("public/order_images/#{order.id}_7.png") if File.exist?("public/order_images/#{order.id}_7.png")
      File.delete("public/order_images/#{order.id}_8.png") if File.exist?("public/order_images/#{order.id}_8.png")
    end
  end
end

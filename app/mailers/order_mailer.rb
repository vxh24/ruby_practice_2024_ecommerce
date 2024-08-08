class OrderMailer < ApplicationMailer
  def order_success_email(user, order)
    @user = user
    @order = order
    mail to: user.email, subject: "Order Confirmation"
  end

  def order_cancelled_email(order)
    @order = order
    @user = @order.user
    mail to: @user.email, subject: "Order Cancelled"
  end

  def order_shipping_email(order)
    @order = order
    @user = @order.user
    mail to: @user.email, subject: "Order Shipping"
  end
end

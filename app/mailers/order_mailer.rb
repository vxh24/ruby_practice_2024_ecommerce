class OrderMailer < ApplicationMailer
  def order_success_email(user, order)
    @user = user
    @order = order
    mail to: user.email, subject: 'Order Confirmation'
  end
end

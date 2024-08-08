class CheckoutController < ApplicationController
  before_action :find_cart, only: %i(new create)
  before_action :find_address, only: %i(new create)
  def new
    @total = Cart.total_for_user(current_user.id)
    @order = Order.new
    @order.build_receiver_info
  end

  def create
    if @carts.empty?
      flash[:danger] = "Cart is empty"
      redirect_to new_checkout_path
    else
      @order = Order.new(order_params)
      @order.date_place_order = Time.current
      if @order.save
        OrderMailer.order_success_email(current_user, @order).deliver_now
        @carts.each do |item|
          OrderDetail.create!(
            order_id: @order.id,
            product_id: item.product_id,
            quantity: item.quantity,
            price: item.product.price
          )
          item.destroy
        end
        flash[:success] = "Order was successfully placed."
        redirect_to order_index_path
      else
        render :new
      end
    end
  end

  private
  def find_cart
    @carts = Cart.for_user(current_user.id)
    return if @carts

    flash[:danger] = "Cart not found!"
    redirect_to root_url
  end
  def find_address
    @user = current_user
    @receiver_infos = @user.receiver_infos
  end
  def receiver_infor_parmas
    params.require(:receiver_infor).permit(:user_id, :name, :phone, :address)
  end
  def order_params
    params.require(:order).permit(:user_id,:total_price, :status,receiver_info_attributes: [:id, :user_id, :name, :phone, :address])
  end
end

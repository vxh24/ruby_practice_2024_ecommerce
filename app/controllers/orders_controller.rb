class OrdersController < ApplicationController
  before_action :set_order, only: %i(show update_info destroy update_status)
  before_action :get_order_detail, only: :show
  before_action :set_receiver, only: %i(show update_info)
  def index
    @orders = Order.for_user(current_user.id).recent_first
  end
  def show
    get_order_detail
  end
  def update_info
    if @receiver_info.update(receiver_info_parmas)
      flash[:success] =  "Success change"
      redirect_to order_update_path
    else
      render :show
    end
  end
  def update_status
    if @order.update(status: params[:status])
      flash[:success] = "Order status updated successfully"
    else
      flash[:danger] = "Failed to update order status"
    end
    redirect_to order_index_path
  end
  def destroy
    if @order.destroy
      flash[:success] = "Order successfully deleted"
    else
      flash[:danger] = "Failed to delete order"
    end
    redirect_to order_index_path
  end

  private

  def set_order
    @order = Order.find_by(id: params[:id])
    return if @order

    flash[:danger] = "Order not found"
    redirect_to root_url
  end
  def set_receiver
    @receiver_info = @order.receiver_info
    return if @receiver_info

    flash[:danger] = "Receiver info not found"
    redirect_to root_url
  end
  def get_order_detail
    @order_details = OrderDetail.for_order(@order.id)
  end
  def receiver_info_parmas
    params.require(:receiver_info).permit(:id, :user_id, :name, :phone, :address)
  end
end

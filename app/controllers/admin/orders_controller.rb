class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: %i(show update)
  before_action :get_order_detail, only: :show

  def index
    @orders = Order.all

    if params[:query].present? || params[:status].present? || (params[:start_date].present? && params[:end_date].present?)
      @orders = @orders.search_by_receiver_name(params[:query])
                       .filter_by_status(params[:status])
                       .filter_by_date(params[:start_date], params[:end_date])
    end

    @pagy, @paginated_orders = pagy @orders, limit: Settings.digist.digist_10
  end

  def show
    get_order_detail
  end

  def update
    if @order.update(order_params)
      OrderMailer.order_cancelled_email(@order).deliver_now if @order.cancelled?
      OrderMailer.order_shipping_email(@order).deliver_now if @order.shipping?
      flash[:success] = "Order was successfully updated."
      redirect_to admin_orders_path
    else
      render :show
    end
  end

  private
  def set_order
    @order = Order.find_by(id: params[:id])

    return if @order

    flash[:alert] = "Order not found."
    redirect_to admin_orders_path
  end

  def get_order_detail
    @order_details = OrderDetail.for_order(@order.id)
  end

  def order_params
    params.require(:order).permit(:status)
  end
end

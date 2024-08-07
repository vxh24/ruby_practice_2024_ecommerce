class CartsController < ApplicationController
  before_action :require_login, only: :show
  before_action :set_cart, only: [:update, :destroy]

  def show
    @carts = Cart.for_user(current_user.id)
    @total = calculate_total
  end

  def add
    @cart = Cart.find_or_initialize_for_user(current_user.id,params[:product_id])
    @cart.quantity ||= 0
    @cart.quantity += params[:quantity].to_i
    @cart.save

    redirect_to carts_path
  end

  def update
    if @cart
      if params[:quantity].to_i > 0
        @cart.update(quantity: params[:quantity].to_i)
        @total = calculate_total
      else
        @cart.destroy
      end
    end

    respond_to do |format|
      format.html { redirect_to carts_path }
      format.turbo_stream
    end
  end

  def destroy
    @cart.destroy if @cart
    respond_to do |format|
      format.html { redirect_to carts_path }
      format.turbo_stream
    end
  end

  private

  def set_cart
    @cart = Cart.find_by(user_id: current_user.id, product_id: params[:product_id])
    return if @cart

    flash[:danger] = "Cart not found"
    redirect_to root_url
  end

  def calculate_total
    Cart.total_for_user(current_user.id)
  end

  def require_login
    unless logged_in?
      flash[:alert] = "Please login."
      redirect_to login_url
    end
  end
end

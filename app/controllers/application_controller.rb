class ApplicationController < ActionController::Base
  before_action :product_count_cart
  include SessionsHelper
  include ProductsHelper
  include Pagy::Backend

  private
  def product_count_cart
    if logged_in?
      @count = Cart.for_user(current_user.id).count
    else
      @count = 0
    end
  end
end

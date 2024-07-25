class ProductsController < ApplicationController
  before_action :find_category
  before_action :set_product, only: :show
  def index
    if params[:query].present?
      @products = @products.search_by_name(params[:query])
      session[:query] = params[:query]
    end
    if params[:price_filter].present? && session[:query].present?
      @products = filter_by_price(@products.search_by_name(session[:query]), params[:price_filter])
    end
    @pagy, @paginated_products = pagy @products, items: Settings.digist.digist_10
    @total_count = @products.size
  end
  def show
  end

  private
  def find_category
    @category = Category.find_by(id: params[:category_id])
    return if @products = Product.by_category(@category)

    flash[:danger] = "Product not found!"
    redirect_to root_url
  end
  def set_product
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:danger] = "Product not found!"
    redirect_to root_url
  end
  def filter_by_price(products, price_filter)
    case price_filter
    when "under_5000"
      products.under_5000
    when "5000_to_10000"
      products.between_5000_and_10000
    when "10000_to_20000"
      products.between_10000_and_20000
    when "over_20000"
      products.over_20000
    else
      products
    end
  end
end

class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: %i(show edit update destroy)
  before_action :load_categories, only: %i(new edit)

  def index
    @products = Product.all

    if params[:query].present?
      @products = @products.search_by_name(params[:query])
    end

    @products = @products.sort_by_name
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html do
          redirect_to admin_products_path,
                      notice: "Product was successfully created."
        end
        format.json{render :show, status: :created, location: @product}
      else
        format.html{render :new, status: :unprocessable_entity}
        format.json{render json: @product.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html do
          redirect_to admin_products_path,
                      notice: "Product was successfully updated."
        end
        format.json{render :show, status: :ok, location: @product}
      else
        format.html{render :edit, status: :unprocessable_entity}
        format.json{render json: @product.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @product.destroy
        format.html do
          redirect_to admin_products_path,
                      notice: "Product was successfully destroyed."
        end
        format.json{head :no_content}
      else
        flash[:danger] = "Delete fail!"
      end
    end
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name,
                                    :description,
                                    :price,
                                    :category_id,
                                    :image)
  end

  def load_categories
    @load_categories ||= Category.all.pluck(:name, :id)
  end
end

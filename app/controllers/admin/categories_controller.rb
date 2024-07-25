class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: %i(show edit update destroy)

  def index
    if params[:query].blank?
      @categories = Category.all
    else
      @categories = Category.search_by_name(params[:query]).sort_by_name
    end

    @pagy, @paginated_categories = pagy @categories, limit: Settings.digist.digist_10
  end

  def show; end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html do
          redirect_to admin_categories_path,
                      notice: "Category was successfully created."
        end
        format.json{render :show, status: :created, location: @category}
      else
        format.html{render :new, status: :unprocessable_entity}
        format.json do
          render json: @category.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html do
          redirect_to admin_categories_path,
                      notice: "Category was successfully updated."
        end
        format.json{render :show, status: :ok, location: @category}
      else
        format.html{render :edit, status: :unprocessable_entity}
        format.json do
          render json: @category.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @category.destroy
        format.html do
          redirect_to admin_categories_path,
                      notice: "Category was successfully destroyed."
        end
        format.json{head :no_content}
      else
        flash[:danger] = "Delete fail!"
      end
    end
  end

  private
  def set_category
    @category = Category.find_by(id: params[:id])

    return if @category

    flash[:alert] = "Category not found."
    redirect_to admin_categories_path
  end

  def category_params
    params.require(:category).permit(:name)
  end
end

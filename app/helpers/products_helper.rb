module ProductsHelper
  def category_options
    Category.all.pluck(:name, :id)
  end
end

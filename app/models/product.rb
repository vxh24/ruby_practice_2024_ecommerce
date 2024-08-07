class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details
  has_one_attached :image do |attachble|
    attachble.variant :display, resize_to_limit: [
      Settings.image.max_width,
      Settings.image.max_height
    ]
  end

  validates :name, :description, :category, presence: true
  validates :price, presence: true, numericality: {greater_than: 0}
  validates :stock_quantity, presence: true,
                             numericality: {
                               only_integer: true,
                               greater_than_or_equal_to: 0
                             }

  scope :sort_by_name, ->{order(name: :asc)}

  scope :search_by_name, lambda {|query|
    if query.present?
      where("name LIKE ?", "%#{query}%")
    else
      all.sort_by_name
    end
  }

  scope :by_category, -> (category) {
    category.present? ? where(category: category) : all
  }

  scope :under_5000, -> {
    where(price: Settings.price.price_0..Settings.price.price_5000)
  }

  scope :between_5000_and_10000, -> {
    where(price: Settings.price.price_5000..Settings.price.price_10000)
  }

  scope :between_10000_and_20000, -> {
    where(price: Settings.price.price_10000..Settings.price.price_20000)
  }

  scope :over_20000, -> {
    where("price > ?", Settings.price.price_20000)
  }
end

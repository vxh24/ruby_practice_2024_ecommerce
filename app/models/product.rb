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
    where("name LIKE ?", "%#{query}%")
  }
end

class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details
  has_one_attached :image do |attachble|
    attachble.variant :display, resize_to_limit: [
      Settings.image.max_width,
      Settings.image.max_height
    ]
  end

  scope :sort_by_name, ->{order(name: :asc)}
  scope :search_by_name, lambda {|query|
    where("name LIKE ?", "%#{query}%")
  }
end

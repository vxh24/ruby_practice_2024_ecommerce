class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  class << self
    def for_user(user_id)
      where(user_id: user_id)
    end

    def total_for_user(user_id)
      for_user(user_id).joins(:product).sum('products.price * carts.quantity')
    end
    def find_or_initialize_for_user(user_id, product_id)
      find_or_initialize_by(user_id: user_id, product_id: product_id)
    end
  end
end

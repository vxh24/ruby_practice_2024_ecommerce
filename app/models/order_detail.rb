class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  has_many :user_comments
  scope :for_order, ->(order_id) { where(order_id: order_id) }
end

class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  has_many :user_comments
end

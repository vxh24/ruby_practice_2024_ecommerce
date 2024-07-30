class Order < ApplicationRecord
  belongs_to :user
  belongs_to :receiver_info
  has_many :order_details
end

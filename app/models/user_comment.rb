class UserComment < ApplicationRecord
  belongs_to :user
  belongs_to :order_detail
end

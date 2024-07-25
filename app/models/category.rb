class Category < ApplicationRecord
  has_many :product, dependent: :destroy
end

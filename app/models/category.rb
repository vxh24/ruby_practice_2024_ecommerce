class Category < ApplicationRecord
  has_many :product, dependent: :destroy
  scope :sort_by_name, ->{order(name: :asc)}
  scope :search_by_name, lambda {|query|
    if query.present?
      where("name LIKE ?", "%#{query}%")
    else
      all.sort_by_name
    end
  }
end

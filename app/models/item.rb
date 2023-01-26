class Item < ApplicationRecord
  validates :product, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence:true
  validates :shipping_cost_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_time_id, presence: true
  validates :price, presence: true
  validates :user, presence: true
end

class Item < ApplicationRecord
  validates :product, presence: true
  validates :description, presence: true
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_cost_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_time_id, presence: true
  validates :price, presence: true
  validates :user, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
end

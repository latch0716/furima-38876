class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one :purchase

  validates :image, presence: true
  validates :product, presence: true, length: { maximum: 40  }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :category_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :condition_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :shipping_cost_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :delivery_time_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :delivery_time
end

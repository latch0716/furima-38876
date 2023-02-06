class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postalcode, :prefecture_id, :city, :block, :building, :phone_number, :token

  # バリデーション
  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postalcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :block
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    binding.pry
    Address.create(postalcode: postalcode, prefecture_id: prefecture_id, city: city, block: block, building: building,
                   phone_number: phone_number, purchase_id: purchase.id)
  end
end

class UserOrder
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city_name, :address, :building_name, \
                :phone_number, :token, :user_id, :item_id, :order_id

  validates :postal_code, :prefecture_id, :city_name, :address, :phone_number, :token, presence: true
  validates :prefecture_id, numericality: { only_integer: true }
  validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }, length: { maximum: 8 }
  validates :phone_number, format: { with: /\d{11}/ }, length: { maximum: 11 }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id, city_name: city_name,
                   address: address, building_name: building_name, phone_number: phone_number)
  end
end

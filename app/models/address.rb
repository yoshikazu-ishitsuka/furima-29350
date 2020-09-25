class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :order

  validates :postal_code, :prefecture, :city_name, :address, :phone_number, presence: true
  validates :prefecture, numericality: { only_integer: true }
  validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }, length: { maximum: 8 }
  validates :phone_number, format: { with: /\d{11}/ }, length: { maximum: 11 }

end

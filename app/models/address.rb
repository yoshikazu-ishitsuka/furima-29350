class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :order
  
  attr_accessor :token

  validates :token, :postal_code, :prefecture_id, :city_name, :address, :phone_number, presence: true
  validates :prefecture_id, :phone_number, numericality: { only_integer: true }
  validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }, length: { maximum: 8 }
  validates :phone_number, format: { with: /\d{1,11}/ }, length: { maximum: 11 }
end

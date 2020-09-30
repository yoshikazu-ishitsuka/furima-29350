class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping_fee_burden
  belongs_to_active_hash :shipping_area
  belongs_to_active_hash :days_to_ship

  belongs_to :user
  has_one_attached :image, dependent: :destroy
  has_one :order

  validates :image, :goods, :details, :category_id, :status_id, :shipping_fee_burden_id, :shipping_area_id, \
            :days_to_ship_id, :price, presence: true

  validates :category_id, :status_id, :shipping_fee_burden_id, :shipping_area_id, :days_to_ship_id, \
            :price, numericality: { only_integer: true }

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'は適正な販売価格を入力してください' }
end

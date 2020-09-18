class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping_fee_burden
  belongs_to_active_hash :shipping_area
  belongs_to_active_hash :days_to_ship


  belongs_to :user
  has_one_attached :image

  validates :goods, :details, :price, presence: true

  validates :category_id, :status_id, :shipping_fee_burden_id, :shipping_area_id, :days_to_ship_id, \
            numericality: { only_integer: true }
end

FactoryBot.define do
  factory :item do
    goods                  { Faker::Food.fruits }
    details                { '商品の説明' }
    category_id            { '1' }
    status_id              { '1' }
    shipping_fee_burden_id { '1' }
    shipping_area_id       { '1' }
    days_to_ship_id        { '1' }
    price                  { Faker::Number.within(range: 300..9_999_999) }
    user_id                { '1' }
    association :user
  end
end

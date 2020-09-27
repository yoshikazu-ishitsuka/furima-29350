FactoryBot.define do
  factory :address do
    postal_code     { '123-4567' }
    prefecture_id   { '1' }
    city_name       { '札幌市' }
    address         { '123' }
    building_name   { 'ビル' }
    phone_number    { '09012345678' }
    order_id        { '1' }
    association :order
  end
end

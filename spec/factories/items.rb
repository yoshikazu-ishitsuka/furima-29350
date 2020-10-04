FactoryBot.define do
  factory :item do
    # image {Faker::Lorem.sentence}
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

    # trait :image do
    #   after(:build) do |item|
    #     File.open("#{Rails.root}/spec/fixtures/sample.png") do |f|
    #       item.images.attach(io: f, filename: "sample.png", content_type: 'image/png')
    #     end
    #   end
    # end

  end
end

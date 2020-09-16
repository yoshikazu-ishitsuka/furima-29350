FactoryBot.define do
  gimei = Gimei.name
  factory :user do
    nickname              { Faker::Name.initials(number: 4) }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { gimei.last.kanji }
    first_name            { gimei.first.kanji }
    last_name_kana        { gimei.last.katakana }
    first_name_kana       { gimei.first.katakana }
    birthday              { Faker::Date.birthday }
  end
end

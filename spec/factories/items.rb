FactoryBot.define do
  factory :item do
    product          {Faker::Name.initials}
    description      {Faker::Lorem.sentence}
    category_id      {Faker::Number.between(from: 2, to: 11)}
    condition_id     {Faker::Number.between(from: 2, to: 7)}
    shipping_cost_id {Faker::Number.between(from: 2, to: 3)}
    prefecture_id    {Faker::Number.between(from: 2, to: 48)}
    delivery_time_id {Faker::Number.between(from: 2, to: 4)}
    price            {Faker::Number.between(from: 300, to: 9999999)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

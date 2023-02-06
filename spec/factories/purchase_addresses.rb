FactoryBot.define do
  factory :purchase_address do
    postalcode    {'123-1234'}
    prefecture_id {Faker::Number.between(from: 2, to: 48)}
    city          {'千代田区'}
    block         {'千代田1-1'}
    building      {'皇居'}
    phone_number  {'09012345678'}
    token         {"tok_abcdefghijk00000000000000000"}

    association :user
    association :item
  end
end

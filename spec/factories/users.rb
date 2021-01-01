FactoryBot.define do
  factory :user do
    # nome { Faker::Name.name }
    email { Faker::Internet.safe_email}
    password { Faker::Internet.password(min_length: 10, max_length: 20)}
    organizacao
    
  end
end

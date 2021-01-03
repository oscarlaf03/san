FactoryBot.define do
  factory :user do
    email { Faker::Internet.safe_email}
    password { Faker::Internet.password(min_length: 10, max_length: 20)}
    organizacao { nil }
  end
end


def user_with_organizacao
  FactoryBot.create(:user, organizacao: FactoryBot.create(:organizacao))
end
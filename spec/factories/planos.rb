FactoryBot.define do
  factory :plano do
    nome { Faker::Company.profession }
    premio_mensal { "" }
    papel { Faker::Company.buzzword }
    acomodacao { Faker::Company.catch_phrase }
    seguradora
  end
end

FactoryBot.define do
  factory :organizacao do
    slug { Faker::Company.buzzword }
    razao_social { Faker::Company.name + ' '+ Faker::Company.suffix }
    cnpj { Faker::Company.brazilian_company_number }
    endereco
  end
end

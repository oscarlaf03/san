FactoryBot.define do
  factory :seguradora do
    cnpj { Faker::Company.brazilian_company_number }
    razao_social { Faker::Company.suffix  }
    nome { Faker::Company.name }
  end
end

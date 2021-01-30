FactoryBot.define do
  factory :organizacao do
    slug { Faker::Company.buzzword }
    nome_fantasia { Faker::Company.name  }
    razao_social { self.nome_fantasia + ' '+ Faker::Company.suffix }
    cnpj { Faker::Company.brazilian_company_number }
    inscricao_municipal { Faker::Number.number(digits: 5) }
    inscricao_estadual { Faker::Number.number(digits: 8) }
    endereco
  end
end

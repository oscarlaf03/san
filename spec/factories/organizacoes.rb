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

def matriz_with_users_and_beneficiarios(number_of_subs=3)
  matriz = FactoryBot.create(:organizacao)
  number_of_subs.times do 
    FactoryBot.create(:organizacao, matriz: matriz)
  end
  matriz.org_group.each do |org|
    2.times do
      FactoryBot.create(:user, organizacao: org)
      FactoryBot.create(:beneficiario, organizacao: org)
    end
  end
  matriz
end

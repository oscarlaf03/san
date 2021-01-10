FactoryBot.define do
  factory :beneficiario do
    nome { Faker::Name.name }
    email { Faker::Internet.safe_email}
    password { Faker::Internet.password(min_length: 10, max_length: 20)}
    organizacao
  end
end


def beneficiario_with_dependentes(vezes=rand(1..4))
  titular = FactoryBot.create(:beneficiario)
  vezes.times do
    FactoryBot.create(:beneficiario, titular: titular, organizacao: titular.organizacao)
  end
  titular
end


def beneficiario_with_titular
  titular = FactoryBot.create(:beneficiario)
  FactoryBot.create(:beneficiario, titular: titular, organizacao: titular.organizacao)
end

def beneficiario_with_banco
  beneficiario =  FactoryBot.create(:beneficiario)
  create(:conta_bancaria, beneficiario: beneficiario)
end


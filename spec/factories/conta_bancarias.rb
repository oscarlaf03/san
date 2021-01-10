FactoryBot.define do
  factory :conta_bancaria do
    banco { Faker::Bank.name }
    codigo_banco {Faker::Number.number(digits: 3).to_s}
    agencia { Faker::Number.number(digits: 4).to_s }
    conta { Faker::Bank.account_number(digits: 13 ).to_s}
    beneficiario
  end
end

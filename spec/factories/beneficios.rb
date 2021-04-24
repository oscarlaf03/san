FactoryBot.define do
  factory :beneficio do
    beneficiario
    organizacao_plano { association :organizacao_plano, organizacao: instance.beneficiario.organizacao}
    carteirinha { Faker::Number.number(digits: 14).to_s }
  end
end

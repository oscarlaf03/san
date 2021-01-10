FactoryBot.define do
  factory :beneficio do
    beneficiario
    organizacao_plano { association :organizacao_plano, organizacao: instance.beneficiario.organizacao}
  end
end

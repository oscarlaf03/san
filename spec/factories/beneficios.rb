FactoryBot.define do
  factory :beneficio do
    beneficiario
    organizacao_plano { association :organizacao_plano, organizacao: instance.beneficiario.organizacao}
    beneficio_condicao { FactoryBot.build(:beneficio_condicao,beneficio: instance, condicao: instance.beneficiario.organizacao.condicoes.first || FactoryBot.create(:condicao, organizacao: instance.beneficiario.organizacao) )}
    carteirinha { Faker::Number.number(digits: 14).to_s }
  end
end

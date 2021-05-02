
FactoryBot.define do
  factory :organizacao_plano do
    plano
    organizacao
    premio_efetivo {rand(400..600) + rand(0..99).to_f / 100}
    dia_corte { [10,5,20,19,2,25,1].sample}
  end
end

FactoryBot.define do
  factory :condicao do
    subisidio_titular { 0.5 }
    subsidio_dependente { 0.25 }
    organizacao
  end
end

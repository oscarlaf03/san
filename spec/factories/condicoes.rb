FactoryBot.define do
  factory :condicao do
    subisidio_titular { 1.5 }
    subsidio_dependente { 1.5 }
    organizacao
  end
end

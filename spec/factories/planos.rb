FactoryBot.define do
  factory :plano do
    nome { "MyString" }
    premio_mensal { "" }
    papel { "MyString" }
    acomodacao { "MyString" }
    aseguradora
  end
end

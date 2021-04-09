FactoryBot.define do
  factory :ticket do
    name_model { %w[ User Organizacao Condicao Beneficio Beneficiario].sample}
    id_model { Faker::Number.number(digits: 2) }
    action { %w[ create update delete ].sample}
    params { "MyString" }
    canceled { false }
    open { false }
    requestor {user_with_organizacao}
    owner { nil }
  end
end

def ticket(**args )
  FactoryBot.create(:ticket, **args)
end

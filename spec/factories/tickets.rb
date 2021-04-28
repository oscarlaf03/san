FactoryBot.define do
  factory :ticket do
    requestor {user_with_organizacao}
    name_model { %w[ User  Beneficiario].sample} # only simple models for factory
    action { %w[ create update destroy ].sample}
    id_model { FactoryBot.create(self.name_model.downcase.to_sym, organizacao: self.requestor.organizacao).id if self.action != 'create'}
    data_vigor { Faker::Date.forward(days: 23)}
    params { nil.to_json }
    canceled { false }
    open { true }
    owner { nil }
  end
end

def ticket(**args )
  FactoryBot.create(:ticket, **args)
end

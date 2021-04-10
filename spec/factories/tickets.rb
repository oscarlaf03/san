FactoryBot.define do
  factory :ticket do
    name_model { %w[ User Organizacao   Beneficiario].sample} # only simple models for factory
    action { %w[ create update destroy ].sample}
    id_model { FactoryBot.create(self.name_model.downcase.to_sym).id if self.action != 'create'}
    params { nil.to_json }
    canceled { false }
    open { false }
    requestor {user_with_organizacao}
    owner { nil }
  end
end

def ticket(**args )
  FactoryBot.create(:ticket, **args)
end

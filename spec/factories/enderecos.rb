FactoryBot.define do
  factory :endereco do
    logradouro { Faker::Address.street_name  }
    numero { Faker::Address.building_number }
    complemento { Faker::Address.secondary_address }
    bairro { Faker::Address.community  }
    cidade { Faker::Address.city }
    estado { Faker::Address.state }
    cep { Faker::Address.postcode  }
    organizacao { nil }
    beneficiario { nil }
  end
end

FactoryBot.define do
  factory :beneficiario do
    genero{ ['homem','mulher'].sample}
    nome { self.genero == 'homem' ? Faker::Name.male_first_name : Faker::Name.female_first_name }
    sobre_nome {Faker::Name.last_name  }
    email { " #{self.nome.parameterize}_#{self.sobre_nome.parameterize}_#{rand.to_s.gsub('.','')}@#{%w[ google gmail yahoo excite geopages geocites].sample}.#{%w[com br mx co tv inc dev net].sample}"}
    cpf { Faker::IDNumber.brazilian_citizen_number }
    matricula {Faker::Number.number(digits: 9) unless self.dependente?}
    password {"123123"}
    organizacao
    endereco
    after(:create) { |beneficiario| beneficiario.confirm }
  end
end


def beneficiario_with_dependentes(vezes=rand(1..4))
  titular = FactoryBot.create(:beneficiario)
  vezes.times do
    FactoryBot.create(:beneficiario, titular: titular, organizacao: titular.organizacao)
  end
  titular
end


def beneficiario_with_titular
  titular = FactoryBot.create(:beneficiario)
  FactoryBot.create(:beneficiario, titular: titular, organizacao: titular.organizacao)
end

def beneficiario_with_banco
  beneficiario =  FactoryBot.create(:beneficiario)
  create(:conta_bancaria, beneficiario: beneficiario)
end


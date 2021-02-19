FactoryBot.define do
  factory :beneficiario do
    genero{ ['homem','mulher'].sample}
    nome { self.genero == 'homem' ? Faker::Name.male_first_name : Faker::Name.female_first_name }
    sobre_nome {Faker::Name.last_name  }
    email { Faker::Internet.safe_email(name: self.nome)}
    cpf { Faker::IDNumber.brazilian_citizen_number }  
    password {"123123"}
    organizacao
    endereco
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


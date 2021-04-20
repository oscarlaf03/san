Beneficiario.all do |beneficiario|
  if  beneficiario.titular?
    (1..4).to_a.sample.times do
      FactoryBot.create(:beneficiario, titular: beneficiario, organizacao: beneficiario.organizacao)
    end
  end
end

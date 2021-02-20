Organizacao.all.each do |org|
  7.times do
    FactoryBot.create(:beneficiario, organizacao: org)
  end
end

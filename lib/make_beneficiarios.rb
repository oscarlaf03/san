Organizacao.all.each do |org|
  if org.beneficiarios.nil?
    3.times do
      FactoryBot.create(:beneficiario, organizacao: org)
    end
  end
end

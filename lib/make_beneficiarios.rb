Organizacao.all.each do |org|
  if org.beneficiarios.blank?
    2.times do
      FactoryBot.create(:beneficiario, organizacao: org)
    end
  end
end

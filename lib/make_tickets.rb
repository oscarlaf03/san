Organizacao.all.each do |org|
  if org.requests.blank?
    (3..8).to_a.sample.times do
      requestor = org.users.sample || FactoryBot.create(:user, organizacao: org, email: "oscar_teste#{rand.to_s.gsub('.','')}@geocities.#{%w[com br mx co tv inc dev net].sample}")
      params = {nome: "nome editado via ticket #{rand.to_s.gsub('.','')} "}
      FactoryBot.create(:ticket, requestor: requestor, name_model: "Beneficiario", id_model: org.beneficiarios.sample.id, params: params.to_json, action: 'update')
    end
  end
end

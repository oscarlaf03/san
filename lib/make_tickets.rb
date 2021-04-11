Organizacao.all.each do |org|
  (3..8).to_a.sample.times do
    requestor = org.users.sample || FactoryBot.create(:user, organizacao: org, email: "safe#{rand.to_s.gsub('.','')}@example3_#{org.slug}.com")
    params = {nome: "nome editado via ticket #{rand.to_s.gsub('.','')} "}
    FactoryBot.create(:ticket, requestor: requestor, name_model: "Beneficiario", id_model: org.beneficiarios.sample.id, params: params.to_json, action: 'update')
  end
end

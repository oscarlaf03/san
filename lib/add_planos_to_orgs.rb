Organizacao.all.each do |org|
  if org.planos.blank?
    OrganizacaoPlano.create(organizacao: org,
      plano: Plano.all.sample,
      premio_efetivo: rand(400..600) + rand(0..99).to_f / 100
    )
  end
end

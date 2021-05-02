OrganizacaoPlano.all.each  do |org_plano|
  if org_plano.premio_efetivo.nil?
    random_premio = rand(400..600) + rand(0..99).to_f / 100
    org_plano.update(premio_efetivo: random_premio)
  end
end

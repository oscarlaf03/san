Beneficio.all.each do |beneficio|
  if beneficio.vigencia.nil?
    beneficio.update(vigencia: [6,12].sample)
  end
  if beneficio.data_inclusao.nil?
    beneficio.update(data_inclusao: Date.today - rand(2..4))
  end
end

OrganizacaoPlano.all.each do |org_plano|

  if org_plano.dia_corte.nil?
    org_plano.update(dia_corte: [10,15,20].sample)
  end

  if org_plano.premio_efetivo.nil?
    org_plano.update(rand(400..600) + rand(0..99).to_f / 100)
  end

end

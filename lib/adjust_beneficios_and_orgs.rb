Beneficio.all.each do |beneficio|
  beneficio.update(
    vigencia: [6,12].sample,
    data_inclusao: Date.today - rand(2..4)
  )
end

OrganizacaoPlano.all.each do |org_plano|
  if org_plano.dia_corte.nil?
    org_plano.update(dia_corte: [ 10,15,20].sample)
  end
end

json.extract! beneficiario, *Beneficiario.params
json.dependentes do
  if beneficiario.dependentes.present?
    json.array! beneficiario.dependentes do |dependente|
      json.extract! dependente, *Beneficiario.params
      json.url api_v1_organizacao_beneficiario_url(dependente.organizacao, dependente, format: :json)
    end
  else
    json.array! []
  end
end
json.url api_v1_organizacao_beneficiario_url(beneficiario.organizacao, beneficiario, format: :json)

json.extract! beneficio, *Beneficio.params
json.url api_v1_organizacao_beneficio_url(beneficio.organizacao_plano.organizacao,beneficio, format: :json)
json.beneficiairo beneficio.beneficiario, *Beneficiario.params
json.plano beneficio.organizacao_plano.plano, *Plano.params
if beneficio.condicao
  json.condicao beneficio.condicao, *Condicao.params
else
  json.condicao do
    json.null!
  end
end

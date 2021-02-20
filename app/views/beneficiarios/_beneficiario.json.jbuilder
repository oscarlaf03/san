json.extract! beneficiario, *Beneficiario.params
json.url api_v1_organizacao_beneficiario_url(beneficiario.organizacao, beneficiario, format: :json)

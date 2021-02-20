json.extract! beneficiario, *Beneficiario.params
json.url organizacao_beneficiario_url(beneficiario.organizacao, beneficiario, format: :json)

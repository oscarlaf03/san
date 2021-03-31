json.extract! organizacao, *Organizacao.params
json.users_count organizacao.users.count
json.beneficiarios_count organizacao.beneficiarios.count
json.endereco organizacao.endereco
json.url api_v1_organizacao_url(organizacao, format: :json)

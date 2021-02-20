json.extract! condicao, *Condicao.params
json.url api_v1_organizacao_condicao_url(condicao.organizacao, condicao, format: :json)


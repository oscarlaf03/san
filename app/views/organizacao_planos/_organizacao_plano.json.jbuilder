json.extract! organizacao_plano, *OrganizacaoPlano.params
json.organizaca_plano_url api_v1_organizacao_organizacao_plano_url(organizacao_plano.organizacao,organizacao_plano, format: :json)
json.plano_url api_v1_seguradora_plano_url(organizacao_plano.plano.seguradora, organizacao_plano.plano, format: :json)
json.plano organizacao_plano.plano, *Plano.params, :nome_seguradora


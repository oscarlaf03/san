json.extract! plano, *Plano.params
json.url api_v1_seguradora_plano_url(plano.seguradora,plano, format: :json)

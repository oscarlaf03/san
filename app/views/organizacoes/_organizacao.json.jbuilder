json.extract! organizacao, :id, :slug, :razao_social, :cnpj, :created_at, :updated_at
json.url organizacao_url(organizacao, format: :json)

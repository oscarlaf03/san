json.extract! conta_bancaria, :id, :banco, :codigo_banco, :agencia, :conta, :beneficiario_id, :created_at, :updated_at
json.url conta_bancaria_url(conta_bancaria, format: :json)

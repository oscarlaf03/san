json.extract! ticket, *Ticket.params
json.organizacao_id ticket.organizacao.id
json.url api_v1_ticket_path(ticket, format: :json)
json.beneficiario do
  if  ["update", "destroy"].include?(ticket.action)
    beneficiario = Beneficiario.find(ticket.id_model)
    json.nome = beneficiario.name
    json.perfil = beneficiario.perfil
    json.parantesco = beneficiario.parentesco
    json.organizacao = beneficiario.organizacao.nome_fantasia
    json.organizacao_id = beneficiario.organizacao_id
    json.carteirinha  = beneficiario.carteirinha
    json.nome_titular = beneficiario.nome_titular
    json.cargo = beneficiario.cargo
    json.localidade = beneficiario.endereco
    json.plano =  beneficiario.plano
  else
    json.null
  end
end

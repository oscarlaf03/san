json.extract! ticket, *Ticket.params
json.organizacao_id ticket.organizacao.id
json.url api_v1_ticket_path(ticket, format: :json)
json.beneficiario do
  if  ["update", "destroy"].include?(ticket.action)
    beneficiario = Beneficiario.find(ticket.id_model)
    json.id beneficiario.id
    json.nome beneficiario.name
    json.perfil beneficiario.perfil
    json.email beneficiario.email
    json.parantesco beneficiario.parentesco
    json.sexo beneficiario.sexo
    json.data_nascimento beneficiario.data_nascimento
    json.estado_civil beneficiario.estado_civil
    json.nome_da_mae beneficiario.nome_da_mae
    json.cpf beneficiario.cpf
    json.matricula beneficiario.matricula
    json.telefone beneficiario.telefone
    json.admissao beneficiario.admissao
    json.organizacao beneficiario.organizacao.nome_fantasia
    json.organizacao_id beneficiario.organizacao_id
    json.carteirinha beneficiario.carteirinha
    json.nome_titular beneficiario.nome_titular
    json.titular_id beneficiario.titular_id
    json.cargo beneficiario.cargo
    json.localidade beneficiario.endereco
    json.plano  beneficiario.plano
  else
    json.null
  end
end

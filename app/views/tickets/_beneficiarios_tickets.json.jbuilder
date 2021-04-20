json.extract! ticket, *Ticket.params
json.organizacao_id ticket.organizacao.id
json.url api_v1_ticket_path(ticket, format: :json)
json.beneficiario do
  if  ["update", "destroy"].include?(ticket.action)
    json.beneficiario json.partial! 'beneficiarios/beneficiario', beneficiario: Beneficiario.find(ticket.id_model)
  else
    json.null
  end

end

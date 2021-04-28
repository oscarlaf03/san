json.extract! ticket, *Ticket.params
json.organizacao_id ticket.requestor.id
json.url api_v1_ticket_path(ticket, format: :json)

class Endereco < BaseModel
  belongs_to :organizacao, optional: true
  belongs_to :beneficiario, optional: true
end

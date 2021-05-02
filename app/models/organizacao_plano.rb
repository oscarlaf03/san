class OrganizacaoPlano < BaseModel
  belongs_to :plano
  belongs_to :organizacao
  has_many :beneficios
  monetize :premio_efetivo_cents

end

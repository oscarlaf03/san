class OrganizacaoPlano < ApplicationRecord
  belongs_to :plano
  belongs_to :organizacao
end

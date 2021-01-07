class Beneficio < ApplicationRecord
  belongs_to :beneficiario
  belongs_to :organizacao_plano
  has_one :beneficio_condicao
  has_one :condicao, through: :beneficio_condicao
end

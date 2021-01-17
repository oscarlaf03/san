class Beneficio < ApplicationRecord
  belongs_to :beneficiario
  belongs_to :organizacao_plano
  has_one :beneficio_condicao, dependent: :destroy
  has_one :condicao, through: :beneficio_condicao
  delegate :plano, to: :organizacao_plano, allow_nil: true
  delegate :organizacao, to: :organizacao_plano, allow_nil: true

end

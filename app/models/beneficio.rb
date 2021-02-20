class Beneficio < BaseModel
  belongs_to :beneficiario
  belongs_to :organizacao_plano
  has_one :beneficio_condicao, dependent: :destroy
  has_one :condicao, through: :beneficio_condicao
  delegate :plano, to: :organizacao_plano, allow_nil: true
  delegate :organizacao, to: :organizacao_plano, allow_nil: true
  accepts_nested_attributes_for :beneficio_condicao,reject_if: :all_blank,  allow_destroy: true
  validates_associated :beneficio_condicao
  validates_presence_of :beneficio_condicao
end

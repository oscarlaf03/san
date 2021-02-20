class Condicao < BaseModel
  belongs_to :organizacao
  has_many :beneficio_condicoes, dependent: :destroy
  has_many :beneficios, through: :beneficio_condicoes
end

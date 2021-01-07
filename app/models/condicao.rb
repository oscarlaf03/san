class Condicao < ApplicationRecord
  belongs_to :organizacao
  has_many :beneficio_condicoes
  has_many :beneficios, through: :beneficio_condicoes
end

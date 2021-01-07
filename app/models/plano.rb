class Plano < ApplicationRecord
  belongs_to :seguradora
  has_many :organizacao_planos
  has_many :organizacoes, through: :organizacao_planos
end

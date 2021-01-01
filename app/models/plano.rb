class Plano < ApplicationRecord
  belongs_to :aseguradora
  has_many :organizacao_planos
  has_many :organizacoes, through: :organizacao_planos
end

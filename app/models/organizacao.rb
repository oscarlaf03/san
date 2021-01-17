class Organizacao < ApplicationRecord
  resourcify
  has_many :users
  has_many :beneficiarios
  has_many :organizacao_planos
  has_many :planos, through: :organizacao_planos
  has_many :condicoes
  validates :cnpj, presence: true, cnpj: true
end

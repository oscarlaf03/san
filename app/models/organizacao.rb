class Organizacao < ApplicationRecord
  resourcify
  has_many :users
  has_many :beneficiarios
  has_many :organizacao_planos, dependent: :destroy
  has_many :planos, through: :organizacao_planos
  has_many :condicoes, dependent: :destroy
  validates :cnpj, presence: true, cnpj: true
end

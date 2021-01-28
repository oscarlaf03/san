class Organizacao < ApplicationRecord
  resourcify
  has_many :users
  has_many :beneficiarios, dependent: :destroy
  has_many :organizacao_planos, dependent: :destroy
  has_many :planos, through: :organizacao_planos
  has_many :condicoes, dependent: :destroy
  has_one :endereco, dependent: :destroy
  accepts_nested_attributes_for :endereco, allow_destroy: true
  validates :cnpj, presence: true, cnpj: true
end

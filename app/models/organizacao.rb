class Organizacao < ApplicationRecord
  has_many :users
  has_many :beneficiarios
  has_many :organizacao_planos
  has_many :planos, through: :organizacao_planos

end

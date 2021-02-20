class Organizacao < BaseModel
  resourcify
  has_many :users, inverse_of: :organizacao
  accepts_nested_attributes_for :users,reject_if: :all_blank,  allow_destroy: true

  has_many :beneficiarios, dependent: :destroy
  has_many :organizacao_planos, dependent: :destroy
  has_many :planos, through: :organizacao_planos
  has_many :beneficios, through: :organizacao_planos
  has_many :condicoes, dependent: :destroy
  has_one :endereco, dependent: :destroy
  accepts_nested_attributes_for :endereco,reject_if: :all_blank,  allow_destroy: true
  validates :cnpj, presence: true, cnpj: true
end

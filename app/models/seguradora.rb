class Seguradora < BaseModel
  has_many :planos, dependent: :destroy
  validates :cnpj, presence: true, cnpj: true

end

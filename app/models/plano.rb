class Plano < BaseModel
  belongs_to :seguradora
  has_many :organizacao_planos
  has_many :organizacoes, through: :organizacao_planos
  validates :nome, presence: :true

  def name
    "#{self.seguradora.nome} -- #{self.nome}"
  end
end

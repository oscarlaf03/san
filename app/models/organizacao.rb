class Organizacao < BaseModel
  resourcify
  has_many :users, inverse_of: :organizacao
  accepts_nested_attributes_for :users,reject_if: :all_blank,  allow_destroy: true

  belongs_to :matriz, class_name: "Organizacao", foreign_key: :matriz_id, optional: true
  has_many :subsidiarias, class_name: "Organizacao", foreign_key: :matriz_id
  has_many :beneficiarios, dependent: :destroy
  has_many :organizacao_planos, dependent: :destroy
  has_many :planos, through: :organizacao_planos
  has_many :beneficios, through: :organizacao_planos
  has_many :condicoes, dependent: :destroy
  has_one :endereco, dependent: :destroy
  has_many :requests, through: :users
  has_many :tickets
  accepts_nested_attributes_for :endereco,reject_if: :all_blank,  allow_destroy: true
  validates :cnpj, presence: true, cnpj: true

  def org_group
    subsidiarias + [self]
  end

  def all_tickets
    return tickets if subsidiarias.blank?
    tickets_subs = []
    subsidiarias.each do |sub|
      tickets_subs += sub.tickets
    end
    tickets_subs + tickets
  end

end
